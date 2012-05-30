From: Rob Lee <rob.lee-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [linux-pm] [PATCH] cpuidle : use percpu cpuidle in the core code
Date: Thu, 31 May 2012 05:45:05 +0800
Message-ID: <CAMXH7KHY+Hgw-n3cM6yNt9x3UPUpBUp96+DqofCCTFcFD+fmgg@mail.gmail.com>
References: <1333104499-8627-1-git-send-email-daniel.lezcano@linaro.org>
	<4F759838.4060007@linux.vnet.ibm.com> <4F759CDE.9060108@linaro.org>
	<4F75A015.2010609@linux.vnet.ibm.com> <4F75DCBE.8000309@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>
In-Reply-To: <4F75DCBE.8000309-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Unsubscribe: <http://lists.linaro.org/mailman/options/linaro-dev>,
	<mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linaro.org/pipermail/linaro-dev>
List-Post: <mailto:linaro-dev-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>
List-Help: <mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.linaro.org/mailman/listinfo/linaro-dev>,
	<mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=subscribe>
Sender: linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org
Errors-To: linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org
To: Daniel Lezcano <daniel.lezcano-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: linux-pm-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linaro-dev-cunTk1MwBs8s++Sfvej+rw@public.gmane.org, "Srivatsa S. Bhat" <srivatsa.bhat-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org>, patches-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org
List-Id: linux-pm@vger.kernel.org

Hey Daniel,

Sorry for the late review/response but perhaps this will still be
useful as your cpuidle work is ongoing.

> Most of the caller are in the boot-up code, in device_init or module_init.
> The other ones are doing some specific initialization on the cpuidle_device
> (cpuinit, like acpi) and can't use the cpuidle_register function.
>

What about adding a callback pointer parameter to the cpuidle_register
function that allows platform specific device initialization to occur
before the cpuidle_device_register call is made?  For reference, see
my old cpuidle common init code that does this at
git://git.linaro.org/people/rob_lee/linux.git cpuidle_init.

With this callback, acpi and the other platforms that need to modify
the cpuidle_device data can use this interface also.  The necessary
acpi cpuidle changes can also be found at the above git URL (although
they haven't been reviewed so they are possibly flawed).

Rob

 _______________________________________________
> linaro-dev mailing list
> linaro-dev-cunTk1MwBs8s++Sfvej+rw@public.gmane.org
> http://lists.linaro.org/mailman/listinfo/linaro-dev
