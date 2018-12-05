From: Georgi Djakov <georgi.djakov@linaro.org>
Subject: Re: [PATCH v10 5/7] interconnect: qcom: Add sdm845 interconnect
 provider driver
Date: Wed, 5 Dec 2018 18:00:44 +0200
Message-ID: <cfcb39ba-860c-5a3f-911f-ab52b5250390@linaro.org>
References: <20181127180349.29997-1-georgi.djakov@linaro.org>
 <20181127180349.29997-6-georgi.djakov@linaro.org>
 <CAE=gft4tO96n0vAubo1_vvcTO4yarDcTNOTuL6cLpmLDDNxrfA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAE=gft4tO96n0vAubo1_vvcTO4yarDcTNOTuL6cLpmLDDNxrfA@mail.gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Evan Green <evgreen@chromium.org>
Cc: linux-pm@vger.kernel.org, gregkh@linuxfoundation.org, rjw@rjwysocki.net, robh+dt@kernel.org, Michael Turquette <mturquette@baylibre.com>, khilman@baylibre.com, Vincent Guittot <vincent.guittot@linaro.org>, Saravana Kannan <skannan@codeaurora.org>, Bjorn Andersson <bjorn.andersson@linaro.org>, amit.kucheria@linaro.org, seansw@qti.qualcomm.com, daidavid1@codeaurora.org, mark.rutland@arm.com, lorenzo.pieralisi@arm.com, Alexandre Bailon <abailon@baylibre.com>, maxime.ripard@bootlin.com, Arnd Bergmann <arnd@arndb.de>, thierry.reding@gmail.com, ksitaraman@nvidia.com, sanjayc@nvidia.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org, linux-tegra@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Hi Evan,

On 12/1/18 02:39, Evan Green wrote:
> On Tue, Nov 27, 2018 at 10:04 AM Georgi Djakov <georgi.djakov@linaro.org> wrote:
>>
>> From: David Dai <daidavid1@codeaurora.org>
>>
>> Introduce Qualcomm SDM845 specific provider driver using the
>> interconnect framework.
>>
>> Signed-off-by: David Dai <daidavid1@codeaurora.org>
>> Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
>> ---
>>  .../bindings/interconnect/qcom,sdm845.txt     |  24 +
>>  drivers/interconnect/Kconfig                  |   5 +
>>  drivers/interconnect/Makefile                 |   1 +
>>  drivers/interconnect/qcom/Kconfig             |  13 +
>>  drivers/interconnect/qcom/Makefile            |   5 +
>>  drivers/interconnect/qcom/sdm845.c            | 836 ++++++++++++++++++
>>  .../dt-bindings/interconnect/qcom,sdm845.h    | 143 +++
>>  7 files changed, 1027 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/interconnect/qcom,sdm845.txt
>>  create mode 100644 drivers/interconnect/qcom/Kconfig
>>  create mode 100644 drivers/interconnect/qcom/Makefile
>>  create mode 100644 drivers/interconnect/qcom/sdm845.c
>>  create mode 100644 include/dt-bindings/interconnect/qcom,sdm845.h
>>
>> diff --git a/Documentation/devicetree/bindings/interconnect/qcom,sdm845.txt b/Documentation/devicetree/bindings/interconnect/qcom,sdm845.txt
>> new file mode 100644
>> index 000000000000..d45150e99665
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/interconnect/qcom,sdm845.txt
>> @@ -0,0 +1,24 @@
>> +Qualcomm SDM845 Network-On-Chip interconnect driver binding
>> +-----------------------------------------------------------
>> +
>> +SDM845 interconnect providers support system bandwidth requirements through
>> +RPMh hardware accelerators known as Bus Clock Manager(BCM). The provider is able
>> +to communicate with the BCM through the Resource State Coordinator(RSC)
>> +associated with each execution environment. Provider nodes must reside within
>> +an RPMh device node pertaining to their RSC and each provider maps to
>> +a single RPMh resource.
>> +
>> +Required properties :
>> +- compatible : shall contain only one of the following:
>> +                       "qcom,sdm845-rsc-hlos"
> 
> I wonder if maybe hlos isn't necessary. Unless you somehow imagine
> secure mode would have a device tree entry in here as well? Probably
> not.

Ok, will remove it. David, please chime in if you have any concerns with
this.

>> +- #interconnect-cells : should contain 1
>> +
>> +Examples:
>> +
>> +apps_rsc: rsc {
>> +               qnoc: qnoc-rsc-hlos {
>> +                       compatible = "qcom,sdm845-rsc-hlos";
>> +                       #interconnect-cells = <1>;
>> +               };
>> +};
>> +
> ...
>> diff --git a/drivers/interconnect/qcom/sdm845.c b/drivers/interconnect/qcom/sdm845.c
>> new file mode 100644
>> index 000000000000..1678de91ca52
>> --- /dev/null
>> +++ b/drivers/interconnect/qcom/sdm845.c
>> @@ -0,0 +1,836 @@
> ...
>> +
>> +static void tcs_list_gen(struct list_head *bcm_list,
>> +                        struct tcs_cmd *tcs_list, int *n)
> 
> We could make the prototype of this function be:
> 
> static void tcs_list_gen(struct list_head *bcm_list,
>         struct tcs_cmd tcs_list[SDM845_MAX_VCD], int n[SDM845_MAX_VCD])
> 
> which would catch errors if somebody later passed in an array that
> wasn't the right size, since we blindly memset below.

Yes, sounds good. I will try to optimize it.

Thanks,
Georgi

>> +{
>> +       struct qcom_icc_bcm *bcm;
>> +       bool commit;
>> +       size_t idx = 0, batch = 0, cur_vcd_size = 0;
>> +
>> +       memset(n, 0, sizeof(int) * SDM845_MAX_VCD);
>> +
>> +       list_for_each_entry(bcm, bcm_list, list) {
>> +               commit = false;
>> +               cur_vcd_size++;
>> +               if ((list_is_last(&bcm->list, bcm_list)) ||
>> +                   bcm->aux_data.vcd != list_next_entry(bcm, list)->aux_data.vcd) {
>> +                       commit = true;
>> +                       cur_vcd_size = 0;
>> +               }
>> +               tcs_cmd_gen(&tcs_list[idx], bcm->vote_x, bcm->vote_y,
>> +                           bcm->addr, commit);
>> +               idx++;
>> +               n[batch]++;
>> +               /*
>> +                * Batch the BCMs in such a way that we do not split them in
>> +                * multiple payloads when they are under the same VCD. This is
>> +                * to ensure that every BCM is committed since we only set the
>> +                * commit bit on the last BCM request of every VCD.
>> +                */
>> +               if (n[batch] >= MAX_RPMH_PAYLOAD) {
>> +                       if (!commit) {
>> +                               n[batch] -= cur_vcd_size;
>> +                               n[batch + 1] = cur_vcd_size;
>> +                       }
>> +                       batch++;
>> +               }
>> +       }
>> +}
>> +
