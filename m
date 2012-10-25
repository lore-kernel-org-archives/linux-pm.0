From: Hongbo Zhang <hongbo.zhang-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH V2 6/6] Thermal: Add ST-Ericsson DB8500 thermal properties
	and platform data.
Date: Thu, 25 Oct 2012 11:45:52 +0800
Message-ID: <CAJLyvQyRBT+p6mkXkhBUx0vOoW+Xo7TqpJ=gHGc-3p_qqjq4UA@mail.gmail.com>
References: <1350387889-15324-1-git-send-email-hongbo.zhang@linaro.com>
	<1351079900-32236-1-git-send-email-hongbo.zhang@linaro.com>
	<1351079900-32236-7-git-send-email-hongbo.zhang@linaro.com>
	<1351089124.18179.12.camel@joe-AO722>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>
In-Reply-To: <1351089124.18179.12.camel@joe-AO722>
List-Unsubscribe: <http://lists.linaro.org/mailman/options/linaro-dev>,
	<mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linaro.org/pipermail/linaro-dev>
List-Post: <mailto:linaro-dev-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>
List-Help: <mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.linaro.org/mailman/listinfo/linaro-dev>,
	<mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=subscribe>
Sender: linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org
Errors-To: linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org
To: Joe Perches <joe-6d6DIl74uiNBDgjK7y7TUQ@public.gmane.org>
Cc: linaro-kernel-cunTk1MwBs8s++Sfvej+rw@public.gmane.org, linaro-dev-cunTk1MwBs8s++Sfvej+rw@public.gmane.org, patches-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, STEricsson_nomadik_linux-nkJGhpqTU55BDgjK7y7TUQ@public.gmane.org, kernel-vMlcbD5RyM6HZuj8yyL1ah2eb7JE58TQ@public.gmane.org, "hongbo.zhang" <hongbo.zhang-68IGFXMjmZ7QT0dZR+AlfA@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

On 24 October 2012 22:32, Joe Perches <joe-6d6DIl74uiNBDgjK7y7TUQ@public.gmane.org> wrote:
> On Wed, 2012-10-24 at 19:58 +0800, hongbo.zhang wrote:
>> This patch adds device tree properties for ST-Ericsson DB8500 thermal driver,
>> also adds the platform data to support the old fashion.
>
> Just a trivial note:
>
>> diff --git a/arch/arm/mach-ux500/board-mop500.c b/arch/arm/mach-ux500/board-mop500.c
>
>> @@ -229,6 +230,67 @@ static struct ab8500_platform_data ab8500_platdata = {
>>  };
>>
>>  /*
>> + * Thermal Sensor
>> + */
>> +
>> +static struct resource db8500_thsens_resources[] = {
>
> should there be a const in any of these?
There will be warnings from gcc:
warning: initialization discards 'const' qualifier from pointer target
type [enabled by default]

>
>> +static struct db8500_thsens_platform_data db8500_thsens_data = {
> []
>> +static struct platform_device u8500_thsens_device = {
> []
>> +static struct platform_device u8500_cpufreq_cooling_device = {
>
>
