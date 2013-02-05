From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: BUG in bleeding edge c560f3d
Date: Tue, 5 Feb 2013 12:38:44 +0530
Message-ID: <CAKohpomDLWFP5tTnhTidOOrkEhW_z5Ht_MzbbnzDaq-i+-1aEg@mail.gmail.com>
References: <511033EA.7090604@gmail.com>
	<3463348.tWNCISaOfi@vostro.rjw.lan>
	<51104CC7.8030800@gmail.com>
	<2585398.78DPBR35EF@vostro.rjw.lan>
	<CAKohpo=-A+VTxsrMQk5SthHZLywrO-E3EHQnSs3_jG593cJzUw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=e89a8ff25350550fe104d4f4e176
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <CAKohpo=-A+VTxsrMQk5SthHZLywrO-E3EHQnSs3_jG593cJzUw@mail.gmail.com>
Sender: cpufreq-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Dirk Brandewie <dirk.brandewie@gmail.com>, cpufreq@vger.kernel.org, Linux PM list <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

--e89a8ff25350550fe104d4f4e176
Content-Type: text/plain; charset=ISO-8859-1

On 5 February 2013 11:15, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> On 5 February 2013 08:13, Rafael J. Wysocki <rjw@sisk.pl> wrote:
>> On Monday, February 04, 2013 04:05:27 PM Dirk Brandewie wrote:
>
>>> Rebased a couple of hours ago testing now.  ATM it looks like it is related to
>>> cpufreq_stats handling of the sysfs files
>>
>> This looks like a problem with commit b8eed8a.  Viresh?
>
> I had some direct chat with Dirk to understand his problem. He has got lots
> of minor changes, which by themselves looks incorrect, for ex:
> - He is required to cpufreq_frequency_table_put_attr() from his drivers
>   init() code to make it NULL... But it should already have been NULL as per
>   my understanding. I really want him to test his driver without any additional
>   target/set_policy() patches he has.. to see if linux-next works for
> him or not.
>
> He will do this testing tomorrow and will let us know of any issues he faces.
>
> We have already tested linux-next and these patches on ARM TC2 and STE
> u8500 (by Fabio), with reboots and lots of hotplugging.
>
> Though i am still going to review my own patches once more to see if there is
> scope for improvement.

The system on which Dirk is testing his patches has following configuration:
1 Package, 4 cpus, 8 virtual cores...

Though they share their clock line in some way, it is handled by the
cpufreq driver
only and for the outside world (cpufreq core), it looks as there are 8
independent cpus,
and so 8 policy structures.

I tried to reproduce the issue at my end by removing extra cpus from
my clusters and
just keeping one per cluster alive from DT.

And i *wasn't* able to reproduce the problem. Though i was able to
find a small bug/issue
in the current code for which i have following patch (attached too):

@Dirk: Please give this one a try. Atleast on my system with various
configurations, i
couldn't see any different this patch has made, but is more logical to me.

commit 9bdd6d47403e696d05953870019e791806f8d6bf
Author: Viresh Kumar <viresh.kumar@linaro.org>
Date:   Tue Feb 5 12:28:18 2013 +0530

    cpufreq: Don't remove sysfs link for policy->cpu

    "cpufreq" directory in policy->cpu is never created using
sysfs_create_link(),
    but using kobject_init_and_add(). And so we shouldn't call
sysfs_remove_link()
    for policy->cpu(). sysfs stuff for policy->cpu is automatically
removed when we
    call kobject_put() for dying policy.

    Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/cpufreq.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 7aacfbf..9567451 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -1047,7 +1047,9 @@ static int __cpufreq_remove_dev(struct device
*dev, struct subsys_interface *sif
        cpus = cpumask_weight(data->cpus);
        cpumask_clear_cpu(cpu, data->cpus);

-       if (unlikely((cpu == data->cpu) && (cpus > 1))) {
+       if (cpu != data->cpu) {
+               sysfs_remove_link(&dev->kobj, "cpufreq");
+       } else if (cpus > 1) {
                /* first sibling now owns the new sysfs dir */
                cpu_dev = get_cpu_device(cpumask_first(data->cpus));
                sysfs_remove_link(&cpu_dev->kobj, "cpufreq");
@@ -1072,7 +1074,6 @@ static int __cpufreq_remove_dev(struct device
*dev, struct subsys_interface *sif
        pr_debug("%s: removing link, cpu: %d\n", __func__, cpu);
        cpufreq_cpu_put(data);
        unlock_policy_rwsem_write(cpu);
-       sysfs_remove_link(&dev->kobj, "cpufreq");

        /* If cpu is last user of policy, free policy */
        if (cpus == 1) {

--e89a8ff25350550fe104d4f4e176
Content-Type: application/octet-stream;
	name="0001-cpufreq-Don-t-remove-sysfs-link-for-policy-cpu.patch"
Content-Disposition: attachment;
	filename="0001-cpufreq-Don-t-remove-sysfs-link-for-policy-cpu.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_hcspiqhp0

RnJvbSA5YmRkNmQ0NzQwM2U2OTZkMDU5NTM4NzAwMTllNzkxODA2ZjhkNmJmIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpNZXNzYWdlLUlkOiA8OWJkZDZkNDc0MDNlNjk2ZDA1OTUzODcwMDE5ZTc5
MTgwNmY4ZDZiZi4xMzYwMDQ3NzQ0LmdpdC52aXJlc2gua3VtYXJAbGluYXJvLm9yZz4KRnJvbTog
VmlyZXNoIEt1bWFyIDx2aXJlc2gua3VtYXJAbGluYXJvLm9yZz4KRGF0ZTogVHVlLCA1IEZlYiAy
MDEzIDEyOjI4OjE4ICswNTMwClN1YmplY3Q6IFtQQVRDSF0gY3B1ZnJlcTogRG9uJ3QgcmVtb3Zl
IHN5c2ZzIGxpbmsgZm9yIHBvbGljeS0+Y3B1CgoiY3B1ZnJlcSIgZGlyZWN0b3J5IGluIHBvbGlj
eS0+Y3B1IGlzIG5ldmVyIGNyZWF0ZWQgdXNpbmcgc3lzZnNfY3JlYXRlX2xpbmsoKSwKYnV0IHVz
aW5nIGtvYmplY3RfaW5pdF9hbmRfYWRkKCkuIEFuZCBzbyB3ZSBzaG91bGRuJ3QgY2FsbCBzeXNm
c19yZW1vdmVfbGluaygpCmZvciBwb2xpY3ktPmNwdSgpLiBzeXNmcyBzdHVmZiBmb3IgcG9saWN5
LT5jcHUgaXMgYXV0b21hdGljYWxseSByZW1vdmVkIHdoZW4gd2UKY2FsbCBrb2JqZWN0X3B1dCgp
IGZvciBkeWluZyBwb2xpY3kuCgpTaWduZWQtb2ZmLWJ5OiBWaXJlc2ggS3VtYXIgPHZpcmVzaC5r
dW1hckBsaW5hcm8ub3JnPgotLS0KIGRyaXZlcnMvY3B1ZnJlcS9jcHVmcmVxLmMgfCA1ICsrKy0t
CiAxIGZpbGUgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQoKZGlmZiAt
LWdpdCBhL2RyaXZlcnMvY3B1ZnJlcS9jcHVmcmVxLmMgYi9kcml2ZXJzL2NwdWZyZXEvY3B1ZnJl
cS5jCmluZGV4IDdhYWNmYmYuLjk1Njc0NTEgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvY3B1ZnJlcS9j
cHVmcmVxLmMKKysrIGIvZHJpdmVycy9jcHVmcmVxL2NwdWZyZXEuYwpAQCAtMTA0Nyw3ICsxMDQ3
LDkgQEAgc3RhdGljIGludCBfX2NwdWZyZXFfcmVtb3ZlX2RldihzdHJ1Y3QgZGV2aWNlICpkZXYs
IHN0cnVjdCBzdWJzeXNfaW50ZXJmYWNlICpzaWYKIAljcHVzID0gY3B1bWFza193ZWlnaHQoZGF0
YS0+Y3B1cyk7CiAJY3B1bWFza19jbGVhcl9jcHUoY3B1LCBkYXRhLT5jcHVzKTsKIAotCWlmICh1
bmxpa2VseSgoY3B1ID09IGRhdGEtPmNwdSkgJiYgKGNwdXMgPiAxKSkpIHsKKwlpZiAoY3B1ICE9
IGRhdGEtPmNwdSkgeworCQlzeXNmc19yZW1vdmVfbGluaygmZGV2LT5rb2JqLCAiY3B1ZnJlcSIp
OworCX0gZWxzZSBpZiAoY3B1cyA+IDEpIHsKIAkJLyogZmlyc3Qgc2libGluZyBub3cgb3ducyB0
aGUgbmV3IHN5c2ZzIGRpciAqLwogCQljcHVfZGV2ID0gZ2V0X2NwdV9kZXZpY2UoY3B1bWFza19m
aXJzdChkYXRhLT5jcHVzKSk7CiAJCXN5c2ZzX3JlbW92ZV9saW5rKCZjcHVfZGV2LT5rb2JqLCAi
Y3B1ZnJlcSIpOwpAQCAtMTA3Miw3ICsxMDc0LDYgQEAgc3RhdGljIGludCBfX2NwdWZyZXFfcmVt
b3ZlX2RldihzdHJ1Y3QgZGV2aWNlICpkZXYsIHN0cnVjdCBzdWJzeXNfaW50ZXJmYWNlICpzaWYK
IAlwcl9kZWJ1ZygiJXM6IHJlbW92aW5nIGxpbmssIGNwdTogJWRcbiIsIF9fZnVuY19fLCBjcHUp
OwogCWNwdWZyZXFfY3B1X3B1dChkYXRhKTsKIAl1bmxvY2tfcG9saWN5X3J3c2VtX3dyaXRlKGNw
dSk7Ci0Jc3lzZnNfcmVtb3ZlX2xpbmsoJmRldi0+a29iaiwgImNwdWZyZXEiKTsKIAogCS8qIElm
IGNwdSBpcyBsYXN0IHVzZXIgb2YgcG9saWN5LCBmcmVlIHBvbGljeSAqLwogCWlmIChjcHVzID09
IDEpIHsKLS0gCjEuNy4xMi5yYzIuMTguZzYxYjQ3MmUKCg==
--e89a8ff25350550fe104d4f4e176--
