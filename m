From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] cpufreq: ARM big LITTLE: Add generic cpufreq driver and
 its DT glue
Date: Wed, 6 Mar 2013 00:38:36 +0800
Message-ID: <CAKohponef2XNN2i8Dn7aBnzcdJeCmuGrmN3HjaBUZvBHkNSLKQ@mail.gmail.com>
References: <f20e3c5e822c4bd28a3b71264d73143cc1f850b0.1362458878.git.viresh.kumar@linaro.org>
	<20130305105251.GL17833@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <20130305105251.GL17833@n2100.arm.linux.org.uk>
Sender: cpufreq-owner@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: rjw@sisk.pl, Steve.Bannister@arm.com, linux-pm@vger.kernel.org, Sudeep KarkadaNagesha <sudeep.karkadanagesha@arm.com>, Liviu.Dudau@arm.com, linux-kernel@vger.kernel.org, cpufreq@vger.kernel.org, robin.randhawa@arm.com, linux-arm-kernel@lists.infradead.org, mark.hambleton@broadcom.com, linaro-kernel@lists.linaro.org, charles.garcia-tobin@arm.com
List-Id: linux-pm@vger.kernel.org

On 5 March 2013 18:52, Russell King - ARM Linux <linux@arm.linux.org.uk> wrote:
> On Tue, Mar 05, 2013 at 12:52:41PM +0800, Viresh Kumar wrote:
>> +static void put_cluster_clk_and_freq_table(u32 cluster)
>> +{
>> +     if (!atomic_dec_return(&cluster_usage[cluster])) {
>> +             clk_put(clk[cluster]);
>> +             clk[cluster] = NULL;
>
> What's the point in setting the clk to NULL?

I couldn't find one and the same is true for freq_table[] too.

>> +static int get_cluster_clk_and_freq_table(u32 cluster)
>> +{
>> +     char name[9] = "cluster";
>> +     int count;
>> +
>> +     if (atomic_inc_return(&cluster_usage[cluster]) != 1)
>> +             return 0;
>> +
>> +     freq_table[cluster] = arm_bL_ops->get_freq_tbl(cluster, &count);
>> +     if (!freq_table[cluster])
>> +             goto atomic_dec;
>> +
>> +     name[7] = cluster + '0';
>> +     clk[cluster] = clk_get(NULL, name);
>> +     if (!IS_ERR_OR_NULL(clk[cluster])) {
>
> NAK.  Two reasons.
>
> 1. IS_ERR_OR_NULL.  You know about this, it's been on the list several
>    times.

AAHHHHHH .. How can i mess up with this concept.. I am really feeling bad now.

> 2. Maybe clk_get_sys() rather than clk_get() and use a sensible device
>    name ("cpu-cluster.%u" maybe) rather than a connection name with a
>    NULL device?

That's a good comment (rather than pointing at some stupid mistake), I will
probably keep the same name for the device as well.

So how does below fix look to you?

----------x-----------------x-----------------
diff --git a/drivers/cpufreq/arm_big_little.c b/drivers/cpufreq/arm_big_little.c
index 0d6de0e..2486b9a 100644
--- a/drivers/cpufreq/arm_big_little.c
+++ b/drivers/cpufreq/arm_big_little.c
@@ -140,9 +140,7 @@ static void put_cluster_clk_and_freq_table(u32 cluster)
 {
        if (!atomic_dec_return(&cluster_usage[cluster])) {
                clk_put(clk[cluster]);
-               clk[cluster] = NULL;
                arm_bL_ops->put_freq_tbl(cluster);
-               freq_table[cluster] = NULL;
                pr_debug("%s: cluster: %d\n", __func__, cluster);
        }
 }
@@ -160,8 +158,8 @@ static int get_cluster_clk_and_freq_table(u32 cluster)
                goto atomic_dec;

        name[7] = cluster + '0';
-       clk[cluster] = clk_get(NULL, name);
-       if (!IS_ERR_OR_NULL(clk[cluster])) {
+       clk[cluster] = clk_get_sys(name, NULL);
+       if (!IS_ERR(clk[cluster])) {
                pr_debug("%s: clk: %p & freq table: %p, cluster: %d\n",
                                __func__, clk[cluster], freq_table[cluster],
                                cluster);
