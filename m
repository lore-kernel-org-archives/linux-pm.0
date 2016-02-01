From: "David.Wu" <wdc@rock-chips.com>
Subject: Re: [PATCH] PM / AVS: rockchip-io: add GRF and PMUGRF types to
 distinguish
Date: Mon, 1 Feb 2016 16:54:38 +0800
Message-ID: <56AF1D4E.40307@rock-chips.com>
References: <1454155305-55516-1-git-send-email-david.wu@rock-chips.com>
 <5387650.lAgTxexlF2@phil>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------000005020907080801000405"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <5387650.lAgTxexlF2@phil>
Sender: linux-kernel-owner@vger.kernel.org
To: Heiko Stuebner <heiko@sntech.de>, David Wu <david.wu@rock-chips.com>
Cc: khilman@kernel.org, nm@ti.com, huangtao@rock-chips.com, cf@rock-chips.com, zyw@rock-chips.com, xjq@rock-chips.com, linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

This is a multi-part message in MIME format.
--------------000005020907080801000405
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Heiko,

在 2016/1/30 20:39, Heiko Stuebner 写道:
> Hi David,
>
> Am Samstag, 30. Januar 2016, 20:01:45 schrieb David Wu:
>> As rk3368 contained two separated iodomain areas, this was
>> determined to use which regmap base address.
>>
>> Signed-off-by: David Wu <david.wu@rock-chips.com>
> I don't think we need to specify this on a driver level. Both GRF areas are
> "General register files" only located in two separate power-domains.
> So the rockchip,grf property should work for both. Especially as nothing
> keeps designers from introducing yet another GRF-area somewhere else ;-)
>
> >From when I started working on the rk3368, I still have a preliminary
> patches for that sitting here, so I've attached on how I envisoned that to
> work.

Okay, i agree to you, but it make someone a little confused just from 
the drive code,
not DT file,  about  pmugrf regmap base address.:-)

How do you feel about intergating GRF and PMU drivers in one driver?
Thanks!

>
> Heiko
>
>> ---
>>   drivers/power/avs/rockchip-io-domain.c | 32
>> ++++++++++++++++++++++++-------- 1 file changed, 24 insertions(+), 8
>> deletions(-)
>>
>> diff --git a/drivers/power/avs/rockchip-io-domain.c
>> b/drivers/power/avs/rockchip-io-domain.c index 8099456..b17aeb7 100644
>> --- a/drivers/power/avs/rockchip-io-domain.c
>> +++ b/drivers/power/avs/rockchip-io-domain.c
>> @@ -47,6 +47,11 @@
>>   #define RK3368_SOC_CON15_FLASH0		BIT(14)
>>   #define RK3368_SOC_FLASH_SUPPLY_NUM	2
>>
>> +enum rockchip_iodomain_grf_type {
>> +	GRF,
>> +	PMUGRF
>> +};
>> +
>>   struct rockchip_iodomain;
>>
>>   /**
>> @@ -54,6 +59,7 @@ struct rockchip_iodomain;
>>    */
>>   struct rockchip_iodomain_soc_data {
>>   	int grf_offset;
>> +	enum rockchip_iodomain_grf_type type;
>>   	const char *supply_names[MAX_SUPPLIES];
>>   	void (*init)(struct rockchip_iodomain *iod);
>>   };
>> @@ -67,7 +73,7 @@ struct rockchip_iodomain_supply {
>>
>>   struct rockchip_iodomain {
>>   	struct device *dev;
>> -	struct regmap *grf;
>> +	struct regmap *base;
>>   	struct rockchip_iodomain_soc_data *soc_data;
>>   	struct rockchip_iodomain_supply supplies[MAX_SUPPLIES];
>>   };
>> @@ -86,7 +92,7 @@ static int rockchip_iodomain_write(struct
>> rockchip_iodomain_supply *supply, /* apply hiword-mask */
>>   	val |= (BIT(supply->idx) << 16);
>>
>> -	ret = regmap_write(iod->grf, iod->soc_data->grf_offset, val);
>> +	ret = regmap_write(iod->base, iod->soc_data->grf_offset, val);
>>   	if (ret)
>>   		dev_err(iod->dev, "Couldn't write to GRF\n");
>>
>> @@ -157,7 +163,7 @@ static void rk3288_iodomain_init(struct
>> rockchip_iodomain *iod) * instead of a special gpio.
>>   	 */
>>   	val = RK3288_SOC_CON2_FLASH0 | (RK3288_SOC_CON2_FLASH0 << 16);
>> -	ret = regmap_write(iod->grf, RK3288_SOC_CON2, val);
>> +	ret = regmap_write(iod->base, RK3288_SOC_CON2, val);
>>   	if (ret < 0)
>>   		dev_warn(iod->dev, "couldn't update flash0 ctrl\n");
>>   }
>> @@ -176,7 +182,7 @@ static void rk3368_iodomain_init(struct
>> rockchip_iodomain *iod) * instead of a special gpio.
>>   	 */
>>   	val = RK3368_SOC_CON15_FLASH0 | (RK3368_SOC_CON15_FLASH0 << 16);
>> -	ret = regmap_write(iod->grf, RK3368_SOC_CON15, val);
>> +	ret = regmap_write(iod->base, RK3368_SOC_CON15, val);
>>   	if (ret < 0)
>>   		dev_warn(iod->dev, "couldn't update flash0 ctrl\n");
>>   }
>> @@ -187,6 +193,7 @@ static void rk3368_iodomain_init(struct
>> rockchip_iodomain *iod) */
>>   static const struct rockchip_iodomain_soc_data soc_data_rk3188 = {
>>   	.grf_offset = 0x104,
>> +	.type = GRF,
>>   	.supply_names = {
>>   		NULL,
>>   		NULL,
>> @@ -209,6 +216,7 @@ static const struct rockchip_iodomain_soc_data
>> soc_data_rk3188 = {
>>
>>   static const struct rockchip_iodomain_soc_data soc_data_rk3288 = {
>>   	.grf_offset = 0x380,
>> +	.type = GRF,
>>   	.supply_names = {
>>   		"lcdc",		/* LCDC_VDD */
>>   		"dvp",		/* DVPIO_VDD */
>> @@ -226,6 +234,7 @@ static const struct rockchip_iodomain_soc_data
>> soc_data_rk3288 = {
>>
>>   static const struct rockchip_iodomain_soc_data soc_data_rk3368 = {
>>   	.grf_offset = 0x900,
>> +	.type = GRF,
>>   	.supply_names = {
>>   		NULL,		/* reserved */
>>   		"dvp",		/* DVPIO_VDD */
>> @@ -242,6 +251,7 @@ static const struct rockchip_iodomain_soc_data
>> soc_data_rk3368 = {
>>
>>   static const struct rockchip_iodomain_soc_data soc_data_rk3368_pmu = {
>>   	.grf_offset = 0x100,
>> +	.type = PMUGRF,
>>   	.supply_names = {
>>   		NULL,
>>   		NULL,
>> @@ -293,10 +303,16 @@ static int rockchip_iodomain_probe(struct
>> platform_device *pdev) match = of_match_node(rockchip_iodomain_match,
>> np);
>>   	iod->soc_data = (struct rockchip_iodomain_soc_data *)match->data;
>>
>> -	iod->grf = syscon_regmap_lookup_by_phandle(np, "rockchip,grf");
>> -	if (IS_ERR(iod->grf)) {
>> -		dev_err(&pdev->dev, "couldn't find grf regmap\n");
>> -		return PTR_ERR(iod->grf);
>> +	if (iod->soc_data->type == PMUGRF)
>> +		iod->base = syscon_regmap_lookup_by_phandle(
>> +				np, "rockchip,pmugrf");
>> +	else
>> +		iod->base = syscon_regmap_lookup_by_phandle(
>> +				np, "rockchip,grf");
>> +	if (IS_ERR(iod->base)) {
>> +		dev_err(&pdev->dev, "couldn't find %s regmap\n",
>> +			(iod->soc_data->type == PMUGRF) ? "pmugrf" : "grf");
>> +		return PTR_ERR(iod->base);
>>   	}
>>
>>   	for (i = 0; i < MAX_SUPPLIES; i++) {


--------------000005020907080801000405
Content-Type: text/plain; charset=UTF-8;
 name="0001-rk3368-io-domain-add-io-domain-volt-sel.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="0001-rk3368-io-domain-add-io-domain-volt-sel.patch"

RnJvbSA3M2NjNTYyNzdjNDJmZDEzYmVkMzkyMWIwN2M4NGFjNGIwMzAzMjFhIE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBEYXZpZCBXdSA8d2RjQHJvY2stY2hpcHMuY29tPgpE
YXRlOiBXZWQsIDI0IERlYyAyMDE0IDE2OjMxOjA5ICswODAwClN1YmplY3Q6IFtQQVRDSCAx
LzVdIHJrMzM2ODogaW8tZG9tYWluOiBhZGQgaW8gZG9tYWluIHZvbHQgc2VsCkNvbnRlbnQt
VHlwZTogdGV4dC9wbGFpbjsgY2hhcnNldD0idXRmLTgiCgpTaWduZWQtb2ZmLWJ5OiBEYXZp
ZCBXdSA8d2RjQHJvY2stY2hpcHMuY29tPgotLS0KIGRyaXZlcnMvcG93ZXIvYXZzL3JvY2tj
aGlwLWlvLWRvbWFpbi5jIHwgMTg0ICsrKysrKysrKysrKysrKysrKysrKysrLS0tLS0tLS0t
LQogMSBmaWxlIGNoYW5nZWQsIDEzMCBpbnNlcnRpb25zKCspLCA1NCBkZWxldGlvbnMoLSkK
CmRpZmYgLS1naXQgYS9kcml2ZXJzL3Bvd2VyL2F2cy9yb2NrY2hpcC1pby1kb21haW4uYyBi
L2RyaXZlcnMvcG93ZXIvYXZzL3JvY2tjaGlwLWlvLWRvbWFpbi5jCmluZGV4IGIxNjAxMzIu
LmQwOTY0NTcgMTAwNzU1Ci0tLSBhL2RyaXZlcnMvcG93ZXIvYXZzL3JvY2tjaGlwLWlvLWRv
bWFpbi5jCisrKyBiL2RyaXZlcnMvcG93ZXIvYXZzL3JvY2tjaGlwLWlvLWRvbWFpbi5jCkBA
IC00MywxOSArNDMsMjggQEAKICNkZWZpbmUgUkszMjg4X1NPQ19DT04yX0ZMQVNIMAkJQklU
KDcpCiAjZGVmaW5lIFJLMzI4OF9TT0NfRkxBU0hfU1VQUExZX05VTQkyCiAKLSNkZWZpbmUg
UkszMzY4X0dSRl9TT0NfQ09OMTUJCQkweDQzYwotI2RlZmluZSBSSzMzNjhfR1JGX1NPQ19D
T04xNV9GTEFTSDAJCUJJVCgxNCkKKyNkZWZpbmUgUkszMzY4X0dSRl9TT0NfQ09OMTUJCTB4
NDNjCisjZGVmaW5lIFJLMzM2OF9HUkZfU09DX0NPTjE1X0ZMQVNIMAlCSVQoMTQpCiAjZGVm
aW5lIFJLMzM2OF9TT0NfRkxBU0hfU1VQUExZX05VTQkyCiAKKyNkZWZpbmUgTUFYX1JPQ0tD
SElQX0dSRl9OVU0gICAgICAgIDIKIAogc3RydWN0IHJvY2tjaGlwX2lvZG9tYWluOwogCiAv
KioKICAqIEBzdXBwbGllczogdm9sdGFnZSBzZXR0aW5ncyBtYXRjaGluZyB0aGUgcmVnaXN0
ZXIgYml0cy4KICAqLworCitlbnVtIHJvY2tjaGlwX2lvZG9tYWluX2dyZl90eXBlIHsKKwlH
UkYsCisJUE1VX0dSRiwKK307CisKIHN0cnVjdCByb2NrY2hpcF9pb2RvbWFpbl9zb2NfZGF0
YSB7CiAJaW50IGdyZl9vZmZzZXQ7Ci0JY29uc3QgY2hhciAqc3VwcGx5X25hbWVzW01BWF9T
VVBQTElFU107CisJaW50IHBtdWdyZl9vZmZzZXQ7CisJY29uc3QgY2hhciAqZ3JmX3N1cHBs
eV9uYW1lc1tNQVhfU1VQUExJRVNdOworCWNvbnN0IGNoYXIgKnBtdWdyZl9zdXBwbHlfbmFt
ZXNbTUFYX1NVUFBMSUVTXTsKIAl2b2lkICgqaW5pdCkoc3RydWN0IHJvY2tjaGlwX2lvZG9t
YWluICppb2QpOwogfTsKIApAQCAtNjQsMTkgKzczLDI0IEBAIHN0cnVjdCByb2NrY2hpcF9p
b2RvbWFpbl9zdXBwbHkgewogCXN0cnVjdCByZWd1bGF0b3IgKnJlZzsKIAlzdHJ1Y3Qgbm90
aWZpZXJfYmxvY2sgbmI7CiAJaW50IGlkeDsKKwllbnVtIHJvY2tjaGlwX2lvZG9tYWluX2dy
Zl90eXBlIHR5cGU7CiB9OwogCiBzdHJ1Y3Qgcm9ja2NoaXBfaW9kb21haW4gewogCXN0cnVj
dCBkZXZpY2UgKmRldjsKIAlzdHJ1Y3QgcmVnbWFwICpncmY7CisJc3RydWN0IHJlZ21hcCAq
cG11OwogCXN0cnVjdCByb2NrY2hpcF9pb2RvbWFpbl9zb2NfZGF0YSAqc29jX2RhdGE7Ci0J
c3RydWN0IHJvY2tjaGlwX2lvZG9tYWluX3N1cHBseSBzdXBwbGllc1tNQVhfU1VQUExJRVNd
OworCXN0cnVjdCByb2NrY2hpcF9pb2RvbWFpbl9zdXBwbHkgZ3JmX3N1cHBsaWVzW01BWF9T
VVBQTElFU107CisJc3RydWN0IHJvY2tjaGlwX2lvZG9tYWluX3N1cHBseSBwbXVncmZfc3Vw
cGxpZXNbTUFYX1NVUFBMSUVTXTsKIH07CiAKIHN0YXRpYyBpbnQgcm9ja2NoaXBfaW9kb21h
aW5fd3JpdGUoc3RydWN0IHJvY2tjaGlwX2lvZG9tYWluX3N1cHBseSAqc3VwcGx5LAogCQkJ
CSAgIGludCB1VikKIHsKIAlzdHJ1Y3Qgcm9ja2NoaXBfaW9kb21haW4gKmlvZCA9IHN1cHBs
eS0+aW9kOworCXN0cnVjdCByZWdtYXAgKnJlZzsKKwlpbnQgb2Zmc2V0OwogCXUzMiB2YWw7
CiAJaW50IHJldDsKIApAQCAtODcsNyArMTAxLDE1IEBAIHN0YXRpYyBpbnQgcm9ja2NoaXBf
aW9kb21haW5fd3JpdGUoc3RydWN0IHJvY2tjaGlwX2lvZG9tYWluX3N1cHBseSAqc3VwcGx5
LAogCS8qIGFwcGx5IGhpd29yZC1tYXNrICovCiAJdmFsIHw9IChCSVQoc3VwcGx5LT5pZHgp
IDw8IDE2KTsKIAotCXJldCA9IHJlZ21hcF93cml0ZShpb2QtPmdyZiwgaW9kLT5zb2NfZGF0
YS0+Z3JmX29mZnNldCwgdmFsKTsKKwlpZiAoc3VwcGx5LT50eXBlID09IEdSRikgeworCQly
ZWcgPSBpb2QtPmdyZjsKKwkJb2Zmc2V0ID0gaW9kLT5zb2NfZGF0YS0+Z3JmX29mZnNldDsK
Kwl9IGVsc2UgaWYgKHN1cHBseS0+dHlwZSA9PSBQTVVfR1JGKSB7CisJCXJlZyA9IGlvZC0+
cG11OworCQlvZmZzZXQgPSBpb2QtPnNvY19kYXRhLT5wbXVncmZfb2Zmc2V0OworCX0KKwor
CXJldCA9IHJlZ21hcF93cml0ZShyZWcsIG9mZnNldCwgdmFsKTsKIAlpZiAocmV0KQogCQlk
ZXZfZXJyKGlvZC0+ZGV2LCAiQ291bGRuJ3Qgd3JpdGUgdG8gR1JGXG4iKTsKIApAQCAtMTUw
LDcgKzE3Miw3IEBAIHN0YXRpYyB2b2lkIHJrMzI4OF9pb2RvbWFpbl9pbml0KHN0cnVjdCBy
b2NrY2hpcF9pb2RvbWFpbiAqaW9kKQogCXUzMiB2YWw7CiAKIAkvKiBpZiBubyBmbGFzaCBz
dXBwbHkgd2Ugc2hvdWxkIGxlYXZlIHRoaW5ncyBhbG9uZSAqLwotCWlmICghaW9kLT5zdXBw
bGllc1tSSzMyODhfU09DX0ZMQVNIX1NVUFBMWV9OVU1dLnJlZykKKwlpZiAoIWlvZC0+Z3Jm
X3N1cHBsaWVzW1JLMzI4OF9TT0NfRkxBU0hfU1VQUExZX05VTV0ucmVnKQogCQlyZXR1cm47
CiAKIAkvKgpAQCAtMTY5LDcgKzE5MSw3IEBAIHN0YXRpYyB2b2lkIHJrMzM2OF9pb2RvbWFp
bl9pbml0KHN0cnVjdCByb2NrY2hpcF9pb2RvbWFpbiAqaW9kKQogCXUzMiB2YWw7CiAKIAkv
KiBpZiBubyBmbGFzaCBzdXBwbHkgd2Ugc2hvdWxkIGxlYXZlIHRoaW5ncyBhbG9uZSAqLwot
CWlmICghaW9kLT5zdXBwbGllc1tSSzMzNjhfU09DX0ZMQVNIX1NVUFBMWV9OVU1dLnJlZykK
KwlpZiAoIWlvZC0+Z3JmX3N1cHBsaWVzW1JLMzM2OF9TT0NfRkxBU0hfU1VQUExZX05VTV0u
cmVnKQogCQlyZXR1cm47CiAKIAkvKgpAQCAtMTg5LDcgKzIxMSw3IEBAIHN0YXRpYyB2b2lk
IHJrMzM2OF9pb2RvbWFpbl9pbml0KHN0cnVjdCByb2NrY2hpcF9pb2RvbWFpbiAqaW9kKQog
ICovCiBzdGF0aWMgY29uc3Qgc3RydWN0IHJvY2tjaGlwX2lvZG9tYWluX3NvY19kYXRhIHNv
Y19kYXRhX3JrMzE4OCA9IHsKIAkuZ3JmX29mZnNldCA9IDB4MTA0LAotCS5zdXBwbHlfbmFt
ZXMgPSB7CisJLmdyZl9zdXBwbHlfbmFtZXMgPSB7CiAJCU5VTEwsCiAJCU5VTEwsCiAJCU5V
TEwsCkBAIC0yMTEsNyArMjMzLDcgQEAgc3RhdGljIGNvbnN0IHN0cnVjdCByb2NrY2hpcF9p
b2RvbWFpbl9zb2NfZGF0YSBzb2NfZGF0YV9yazMxODggPSB7CiAKIHN0YXRpYyBjb25zdCBz
dHJ1Y3Qgcm9ja2NoaXBfaW9kb21haW5fc29jX2RhdGEgc29jX2RhdGFfcmszMjg4ID0gewog
CS5ncmZfb2Zmc2V0ID0gMHgzODAsCi0JLnN1cHBseV9uYW1lcyA9IHsKKwkuZ3JmX3N1cHBs
eV9uYW1lcyA9IHsKIAkJImxjZGMiLAkJLyogTENEQ19WREQgKi8KIAkJImR2cCIsCQkvKiBE
VlBJT19WREQgKi8KIAkJImZsYXNoMCIsCS8qIEZMQVNIMF9WREQgKGVtbWMpICovCkBAIC0y
MjgsMTYgKzI1MCwyNSBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IHJvY2tjaGlwX2lvZG9tYWlu
X3NvY19kYXRhIHNvY19kYXRhX3JrMzI4OCA9IHsKIAogc3RhdGljIGNvbnN0IHN0cnVjdCBy
b2NrY2hpcF9pb2RvbWFpbl9zb2NfZGF0YSBzb2NfZGF0YV9yazMzNjggPSB7CiAJLmdyZl9v
ZmZzZXQgPSAweDkwMCwKLQkuc3VwcGx5X25hbWVzID0geworCS5wbXVncmZfb2Zmc2V0ID0g
MHgxMDAsCisJLmdyZl9zdXBwbHlfbmFtZXMgPSB7CisJCU5VTEwsCisJCSJkdnAiLAkJLypE
VlAgSU8gZG9tYWluKi8KKwkJImZsYXNoMCIsCS8qRkxBU0gwIElPIGRvbWFpbiovCisJCSJ3
aWZpIiwgICAgICAgICAvKkFQSU8yIElPIGRvbWFpbiovCisJCU5VTEwsCisJCSJhdWRpbyIs
CS8qQVBJTzMgSU8gZG9tYWluKi8KKwkJInNkY2FyZCIsCS8qU0RDQVJEIElPIGRvbWFpbiov
CisJCSJncGlvMzAiLAkvKkFQSU8xIElPIGRvbWFpbiovCisJCSJncGlvMTgzMCIsCS8qQURJ
TzQgSU8gZG9tYWluKi8KKwl9LAorCS5wbXVncmZfc3VwcGx5X25hbWVzID0geworCQlOVUxM
LAorCQlOVUxMLAogCQlOVUxMLAotCQkiZHZwX3YxOHNlbCIsCQkvKkRWUCBJTyBkb21haW4q
LwotCQkiZmxhc2gwX3YxOHNlbCIsCQkvKkZMQVNIMCBJTyBkb21haW4qLwotCQkid2lmaV92
MThzZWwiLAkvKldJRkkgSU8gZG9tYWluKi8KIAkJTlVMTCwKLQkJImF1ZGlvX3YxOHNlbCIs
CS8qQVVESU8gSU8gZG9tYWluKi8KLQkJInNkY2FyZF92MThzZWwiLAkJLypTRENBUkQgSU8g
ZG9tYWluKi8KLQkJImdwaW8zMF92MThzZWwiLAkJLypHUElPMzAgSU8gZG9tYWluKi8KLQkJ
ImdwaW8xODMwX3YxOHNlbCIsCS8qR1BJTzE4MzAgSU8gZG9tYWluKi8KKwkJInBtdSIsCSAg
ICAgICAgLypQTVUgSU8gZG9tYWluKi8KKwkJInZvcCIsCSAgICAgICAgLypMQ0RDIElPIGRv
bWFpbiovCiAJfSwKIAkuaW5pdCA9IHJrMzM2OF9pb2RvbWFpbl9pbml0LAogfTsKQEAgLTI1
OSw0NyArMjkwLDM0IEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3Qgb2ZfZGV2aWNlX2lkIHJvY2tj
aGlwX2lvZG9tYWluX21hdGNoW10gPSB7CiAJeyAvKiBzZW50aW5lbCAqLyB9LAogfTsKIAot
c3RhdGljIGludCByb2NrY2hpcF9pb2RvbWFpbl9wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2
aWNlICpwZGV2KQorc3RhdGljIGludCByb2NrY2hpcF9pb2RvbWFpbl9wYXJzZV9zdXBwbHko
c3RydWN0IHJvY2tjaGlwX2lvZG9tYWluICppb2QsCisJCQkJCSAgc3RydWN0IGRldmljZV9u
b2RlICpucCwKKwkJCQkJICBlbnVtIHJvY2tjaGlwX2lvZG9tYWluX2dyZl90eXBlIHR5cGUp
CiB7Ci0Jc3RydWN0IGRldmljZV9ub2RlICpucCA9IHBkZXYtPmRldi5vZl9ub2RlOwotCWNv
bnN0IHN0cnVjdCBvZl9kZXZpY2VfaWQgKm1hdGNoOwotCXN0cnVjdCByb2NrY2hpcF9pb2Rv
bWFpbiAqaW9kOworCXN0cnVjdCByb2NrY2hpcF9pb2RvbWFpbl9zdXBwbHkgKmdyb3VwX3N1
cHBseTsKKwljb25zdCBjaGFyICoqZ3JvdXBfc3VwcGx5X25hbWVzOwogCWludCBpLCByZXQg
PSAwOwogCi0JaWYgKCFucCkKLQkJcmV0dXJuIC1FTk9ERVY7Ci0KLQlpb2QgPSBkZXZtX2t6
YWxsb2MoJnBkZXYtPmRldiwgc2l6ZW9mKCppb2QpLCBHRlBfS0VSTkVMKTsKLQlpZiAoIWlv
ZCkKLQkJcmV0dXJuIC1FTk9NRU07Ci0KLQlpb2QtPmRldiA9ICZwZGV2LT5kZXY7Ci0JcGxh
dGZvcm1fc2V0X2RydmRhdGEocGRldiwgaW9kKTsKLQotCW1hdGNoID0gb2ZfbWF0Y2hfbm9k
ZShyb2NrY2hpcF9pb2RvbWFpbl9tYXRjaCwgbnApOwotCWlvZC0+c29jX2RhdGEgPSAoc3Ry
dWN0IHJvY2tjaGlwX2lvZG9tYWluX3NvY19kYXRhICopbWF0Y2gtPmRhdGE7Ci0KLQlpb2Qt
PmdyZiA9IHN5c2Nvbl9yZWdtYXBfbG9va3VwX2J5X3BoYW5kbGUobnAsICJyb2NrY2hpcCxn
cmYiKTsKLQlpZiAoSVNfRVJSKGlvZC0+Z3JmKSkgewotCQlkZXZfZXJyKCZwZGV2LT5kZXYs
ICJjb3VsZG4ndCBmaW5kIGdyZiByZWdtYXBcbiIpOwotCQlyZXR1cm4gUFRSX0VSUihpb2Qt
PmdyZik7CisJaWYgKHR5cGUgPT0gR1JGKSB7CisJCWdyb3VwX3N1cHBseV9uYW1lcyA9CisJ
CQkoY29uc3QgY2hhciAqKilpb2QtPnNvY19kYXRhLT5ncmZfc3VwcGx5X25hbWVzOworCQln
cm91cF9zdXBwbHkgPSBpb2QtPmdyZl9zdXBwbGllczsKKwl9IGVsc2UgaWYgKHR5cGUgPT0g
UE1VX0dSRikgeworCQlncm91cF9zdXBwbHlfbmFtZXMgPQorCQkJKGNvbnN0IGNoYXIgKiop
aW9kLT5zb2NfZGF0YS0+cG11Z3JmX3N1cHBseV9uYW1lczsKKwkJZ3JvdXBfc3VwcGx5ID0g
aW9kLT5wbXVncmZfc3VwcGxpZXM7CiAJfQogCiAJZm9yIChpID0gMDsgaSA8IE1BWF9TVVBQ
TElFUzsgaSsrKSB7Ci0JCWNvbnN0IGNoYXIgKnN1cHBseV9uYW1lID0gaW9kLT5zb2NfZGF0
YS0+c3VwcGx5X25hbWVzW2ldOwotCQlzdHJ1Y3Qgcm9ja2NoaXBfaW9kb21haW5fc3VwcGx5
ICpzdXBwbHkgPSAmaW9kLT5zdXBwbGllc1tpXTsKKwkJY29uc3QgY2hhciAqc3VwcGx5X25h
bWUgPSBncm91cF9zdXBwbHlfbmFtZXNbaV07CisJCXN0cnVjdCByb2NrY2hpcF9pb2RvbWFp
bl9zdXBwbHkgKnN1cHBseSA9ICZncm91cF9zdXBwbHlbaV07CiAJCXN0cnVjdCByZWd1bGF0
b3IgKnJlZzsKIAkJaW50IHVWOwotCQljb25zdCBjaGFyICpyZWd1bGF0b3JfbmFtZSA9IE5V
TEw7CiAKIAkJaWYgKCFzdXBwbHlfbmFtZSkKIAkJCWNvbnRpbnVlOwogCi0JCW9mX3Byb3Bl
cnR5X3JlYWRfc3RyaW5nKG5wLCBzdXBwbHlfbmFtZSwgJnJlZ3VsYXRvcl9uYW1lKTsKLQkJ
aWYgKCFyZWd1bGF0b3JfbmFtZSkKLQkJCWNvbnRpbnVlOwotCi0JCXJlZyA9IHJlZ3VsYXRv
cl9nZXQoTlVMTCwgcmVndWxhdG9yX25hbWUpOworCQlyZWcgPSBkZXZtX3JlZ3VsYXRvcl9n
ZXRfb3B0aW9uYWwoaW9kLT5kZXYsIHN1cHBseV9uYW1lKTsKIAkJaWYgKElTX0VSUihyZWcp
KSB7CiAJCQlyZXQgPSBQVFJfRVJSKHJlZyk7CiAKQEAgLTMzNCw2ICszNTIsNyBAQCBzdGF0
aWMgaW50IHJvY2tjaGlwX2lvZG9tYWluX3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2Ug
KnBkZXYpCiAJCXN1cHBseS0+aWR4ID0gaTsKIAkJc3VwcGx5LT5pb2QgPSBpb2Q7CiAJCXN1
cHBseS0+cmVnID0gcmVnOworCQlzdXBwbHktPnR5cGUgPSB0eXBlOwogCQlzdXBwbHktPm5i
Lm5vdGlmaWVyX2NhbGwgPSByb2NrY2hpcF9pb2RvbWFpbl9ub3RpZnk7CiAKIAkJcmV0ID0g
cm9ja2NoaXBfaW9kb21haW5fd3JpdGUoc3VwcGx5LCB1Vik7CkBAIC0zNDUsMjEgKzM2NCwx
NiBAQCBzdGF0aWMgaW50IHJvY2tjaGlwX2lvZG9tYWluX3Byb2JlKHN0cnVjdCBwbGF0Zm9y
bV9kZXZpY2UgKnBkZXYpCiAJCS8qIHJlZ2lzdGVyIHJlZ3VsYXRvciBub3RpZmllciAqLwog
CQlyZXQgPSByZWd1bGF0b3JfcmVnaXN0ZXJfbm90aWZpZXIocmVnLCAmc3VwcGx5LT5uYik7
CiAJCWlmIChyZXQpIHsKLQkJCWRldl9lcnIoJnBkZXYtPmRldiwKKwkJCWRldl9lcnIoaW9k
LT5kZXYsCiAJCQkJInJlZ3VsYXRvciBub3RpZmllciByZXF1ZXN0IGZhaWxlZFxuIik7CiAJ
CQlzdXBwbHktPnJlZyA9IE5VTEw7CiAJCQlnb3RvIHVucmVnX25vdGlmeTsKIAkJfQogCX0K
IAotCWlmIChpb2QtPnNvY19kYXRhLT5pbml0KQotCQlpb2QtPnNvY19kYXRhLT5pbml0KGlv
ZCk7Ci0KLQlyZXR1cm4gMDsKLQogdW5yZWdfbm90aWZ5OgogCWZvciAoaSA9IE1BWF9TVVBQ
TElFUyAtIDE7IGkgPj0gMDsgaS0tKSB7Ci0JCXN0cnVjdCByb2NrY2hpcF9pb2RvbWFpbl9z
dXBwbHkgKmlvX3N1cHBseSA9ICZpb2QtPnN1cHBsaWVzW2ldOworCQlzdHJ1Y3Qgcm9ja2No
aXBfaW9kb21haW5fc3VwcGx5ICppb19zdXBwbHkgPSAmZ3JvdXBfc3VwcGx5W2ldOwogCiAJ
CWlmIChpb19zdXBwbHktPnJlZykKIAkJCXJlZ3VsYXRvcl91bnJlZ2lzdGVyX25vdGlmaWVy
KGlvX3N1cHBseS0+cmVnLApAQCAtMzY5LDEzICszODMsNzUgQEAgdW5yZWdfbm90aWZ5Ogog
CXJldHVybiByZXQ7CiB9CiAKK3N0YXRpYyBpbnQgcm9ja2NoaXBfaW9kb21haW5fcHJvYmUo
c3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikKK3sKKwlzdHJ1Y3QgZGV2aWNlX25vZGUg
Km5wID0gcGRldi0+ZGV2Lm9mX25vZGUsICpub2RlOworCWNvbnN0IHN0cnVjdCBvZl9kZXZp
Y2VfaWQgKm1hdGNoOworCXN0cnVjdCByb2NrY2hpcF9pb2RvbWFpbiAqaW9kOworCWludCBy
ZXQgPSAwOworCisJaWYgKCFucCkKKwkJcmV0dXJuIC1FTk9ERVY7CisKKwlpb2QgPSBkZXZt
X2t6YWxsb2MoJnBkZXYtPmRldiwgc2l6ZW9mKCppb2QpLCBHRlBfS0VSTkVMKTsKKwlpZiAo
IWlvZCkKKwkJcmV0dXJuIC1FTk9NRU07CisKKwlpb2QtPmRldiA9ICZwZGV2LT5kZXY7CisJ
cGxhdGZvcm1fc2V0X2RydmRhdGEocGRldiwgaW9kKTsKKworCW1hdGNoID0gb2ZfbWF0Y2hf
bm9kZShyb2NrY2hpcF9pb2RvbWFpbl9tYXRjaCwgbnApOworCWlvZC0+c29jX2RhdGEgPSAo
c3RydWN0IHJvY2tjaGlwX2lvZG9tYWluX3NvY19kYXRhICopbWF0Y2gtPmRhdGE7CisKKwlp
b2QtPmdyZiA9IHN5c2Nvbl9yZWdtYXBfbG9va3VwX2J5X3BoYW5kbGUobnAsICJyb2NrY2hp
cCxncmYiKTsKKwlpZiAoSVNfRVJSKGlvZC0+Z3JmKSkgeworCQlkZXZfZXJyKCZwZGV2LT5k
ZXYsICJjb3VsZG4ndCBmaW5kIGdyZiByZWdtYXBcbiIpOworCQlyZXR1cm4gUFRSX0VSUihp
b2QtPmdyZik7CisJfQorCXJldCA9IHJvY2tjaGlwX2lvZG9tYWluX3BhcnNlX3N1cHBseShp
b2QsIG5wLCBHUkYpOworCWlmIChyZXQpIHsKKwkJZGV2X2Vycihpb2QtPmRldiwKKwkJCSJy
b2NrY2hpcCBpb2RvbWFpbiBwYXJzZSBncmYgc3VwcGx5IGZhaWxlZFxuIik7CisJCXJldHVy
biByZXQ7CisJfQorCisJLyogdHJ5IHRvIGZpbmQgdGhlIG9wdGlvbmFsIHJlZmVyZW5jZSB0
byB0aGUgcG11IHN5c2NvbiAqLworCW5vZGUgPSBvZl9wYXJzZV9waGFuZGxlKG5wLCAicm9j
a2NoaXAscG11IiwgMCk7CisJaWYgKG5vZGUpIHsKKwkJaW9kLT5wbXUgPSBzeXNjb25fbm9k
ZV90b19yZWdtYXAobm9kZSk7CisJCWlmIChJU19FUlIoaW9kLT5wbXUpKQorCQkJcmV0dXJu
IFBUUl9FUlIoaW9kLT5wbXUpOworCQlyZXQgPSByb2NrY2hpcF9pb2RvbWFpbl9wYXJzZV9z
dXBwbHkoaW9kLCBucCwgUE1VX0dSRik7CisJCWlmIChyZXQpIHsKKwkJCWRldl9lcnIoaW9k
LT5kZXYsCisJCQkJInJvY2tjaGlwIGlvZG9tYWluIHBhcnNlIHBtdV9ncmYgc3VwcGx5IGZh
aWxlZFxuIik7CisJCQlyZXR1cm4gcmV0OworCQl9CisJfQorCisJaWYgKGlvZC0+c29jX2Rh
dGEtPmluaXQpCisJCWlvZC0+c29jX2RhdGEtPmluaXQoaW9kKTsKKworCXJldHVybiByZXQ7
Cit9CisKIHN0YXRpYyBpbnQgcm9ja2NoaXBfaW9kb21haW5fcmVtb3ZlKHN0cnVjdCBwbGF0
Zm9ybV9kZXZpY2UgKnBkZXYpCiB7CiAJc3RydWN0IHJvY2tjaGlwX2lvZG9tYWluICppb2Qg
PSBwbGF0Zm9ybV9nZXRfZHJ2ZGF0YShwZGV2KTsKIAlpbnQgaTsKIAogCWZvciAoaSA9IE1B
WF9TVVBQTElFUyAtIDE7IGkgPj0gMDsgaS0tKSB7Ci0JCXN0cnVjdCByb2NrY2hpcF9pb2Rv
bWFpbl9zdXBwbHkgKmlvX3N1cHBseSA9ICZpb2QtPnN1cHBsaWVzW2ldOworCQlzdHJ1Y3Qg
cm9ja2NoaXBfaW9kb21haW5fc3VwcGx5ICppb19zdXBwbHkKKwkJCT0gJmlvZC0+Z3JmX3N1
cHBsaWVzW2ldOworCisJCWlmIChpb19zdXBwbHktPnJlZykKKwkJCXJlZ3VsYXRvcl91bnJl
Z2lzdGVyX25vdGlmaWVyKGlvX3N1cHBseS0+cmVnLAorCQkJCQkJICAgICAgJmlvX3N1cHBs
eS0+bmIpOworCX0KKworCWZvciAoaSA9IE1BWF9TVVBQTElFUyAtIDE7IGkgPj0gMDsgaS0t
KSB7CisJCXN0cnVjdCByb2NrY2hpcF9pb2RvbWFpbl9zdXBwbHkgKmlvX3N1cHBseSA9CisJ
CQkmaW9kLT5wbXVncmZfc3VwcGxpZXNbaV07CiAKIAkJaWYgKGlvX3N1cHBseS0+cmVnKQog
CQkJcmVndWxhdG9yX3VucmVnaXN0ZXJfbm90aWZpZXIoaW9fc3VwcGx5LT5yZWcsCi0tIAox
LjkuMQoK
--------------000005020907080801000405--
