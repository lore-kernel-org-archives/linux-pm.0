From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH/RFC] platform_bus: Allow runtime PM by default
Date: Sat, 27 Mar 2010 19:41:40 +0000
Message-ID: <251AAFA3-F44D-40D2-BF99-E82EE58FD52D__20277.0737618723$1269719009$gmane$org@opensource.wolfsonmicro.com>
References: <1269625370-17754-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<201003262335.06941.rjw@sisk.pl>
	(sfid-20100326_223222_633980_AC596020)
Mime-Version: 1.0 (iPhone Mail 7E18)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201003262335.06941.rjw@sisk.pl>
	(sfid-20100326_223222_633980_AC596020)
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: "linux-pm@lists.linux-foundation.org" <linux-pm@lists.linux-foundation.org>, Greg Kroah-Hartman <gregkh@suse.de>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On 26 Mar 2010, at 22:35, "Rafael J. Wysocki" <rjw@sisk.pl> wrote:

> On Friday 26 March 2010, Mark Brown wrote:
>> Currently the default runtime PM callbacks for platform devices  
>> return
>> -ENOSYS, preventing the use of runtime PM platforms until they have
>> provided at least a default implementation. This hinders the use of
>> runtime PM by devices which work with many platforms such as memory
>> mapped devices, MFDs and on chip IPs shared by multiple  
>> architectures.
>>
>> Change the default implementation to the standard pm_generic_runtime
>> one, allowing drivers to use runtime PM without per-architecture
>> changes.
>>
>> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
>
> Acked-by: Rafael J. Wysocki <rjw@sisk.pl>
>
> Is it very urgent?

Not especially - worst case you just don't get devices suspending  
which isn't the end of the world and there's no build time  
dependencies introduced.

>
> Rafael
>
>
>> ---
>>
>> I'm not 100% sure why the curret implementation returns -ENOSYS -  
>> I've
>> got a horrible feeling I might be breaking something somewhere.
>>
>> drivers/base/platform.c |    6 +++---
>> 1 files changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/base/platform.c b/drivers/base/platform.c
>> index 43479a9..eb0f8d9 100644
>> --- a/drivers/base/platform.c
>> +++ b/drivers/base/platform.c
>> @@ -967,17 +967,17 @@ static int platform_pm_restore_noirq(struct  
>> device *dev)
>>
>> int __weak platform_pm_runtime_suspend(struct device *dev)
>> {
>> -    return -ENOSYS;
>> +    return pm_generic_runtime_suspend(dev);
>> };
>>
>> int __weak platform_pm_runtime_resume(struct device *dev)
>> {
>> -    return -ENOSYS;
>> +    return pm_generic_runtime_resume(dev);
>> };
>>
>> int __weak platform_pm_runtime_idle(struct device *dev)
>> {
>> -    return -ENOSYS;
>> +    return pm_generic_runtime_idle(dev);
>> };
>>
>> #else /* !CONFIG_PM_RUNTIME */
>>
>
