From: Hongbo Zhang <hongbo.zhang-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH V2 6/6] Thermal: Add ST-Ericsson DB8500 thermal properties
	and platform data.
Date: Thu, 25 Oct 2012 11:49:48 +0800
Message-ID: <CAJLyvQwhsN9cxy0YSmEGQ__1Wh3ajEmC5G6jpJ7KTXBR=BV+jA@mail.gmail.com>
References: <1350387889-15324-1-git-send-email-hongbo.zhang@linaro.com>
	<1351079900-32236-1-git-send-email-hongbo.zhang@linaro.com>
	<1351079900-32236-7-git-send-email-hongbo.zhang@linaro.com>
	<CAKohpom0EOAuahLQoNr1ODbTT-Trv3eE0-oBEmbbdbiKBJPCng@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>
In-Reply-To: <CAKohpom0EOAuahLQoNr1ODbTT-Trv3eE0-oBEmbbdbiKBJPCng-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <http://lists.linaro.org/mailman/options/linaro-dev>,
	<mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linaro.org/pipermail/linaro-dev>
List-Post: <mailto:linaro-dev-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>
List-Help: <mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.linaro.org/mailman/listinfo/linaro-dev>,
	<mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=subscribe>
Sender: linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org
Errors-To: linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org
To: Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: linaro-kernel-cunTk1MwBs8s++Sfvej+rw@public.gmane.org, linaro-dev-cunTk1MwBs8s++Sfvej+rw@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, patches-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, STEricsson_nomadik_linux-nkJGhpqTU55BDgjK7y7TUQ@public.gmane.org, kernel-vMlcbD5RyM6HZuj8yyL1ah2eb7JE58TQ@public.gmane.org, "hongbo.zhang" <hongbo.zhang-68IGFXMjmZ7QT0dZR+AlfA@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

[...]
>>  /*
>> + * Thermal Sensor
>> + */
>> +
>> +static struct resource db8500_thsens_resources[] = {
>> +       {
>> +               .name = "IRQ_HOTMON_LOW",
>> +               .start  = IRQ_PRCMU_HOTMON_LOW,
>> +               .end    = IRQ_PRCMU_HOTMON_LOW,
>> +               .flags  = IORESOURCE_IRQ,
>> +       },
>> +       {
>
> I prefer }, {
I just follow the style of all the other definitions, let's keep a
uniform style.

>
>> +               .name = "IRQ_HOTMON_HIGH",
>> +               .start  = IRQ_PRCMU_HOTMON_HIGH,
>> +               .end    = IRQ_PRCMU_HOTMON_HIGH,
>> +               .flags  = IORESOURCE_IRQ,
>> +       },
>> +};
[...]
>>
>>
>> _______________________________________________
>> linaro-dev mailing list
>> linaro-dev-cunTk1MwBs8s++Sfvej+rw@public.gmane.org
>> http://lists.linaro.org/mailman/listinfo/linaro-dev
