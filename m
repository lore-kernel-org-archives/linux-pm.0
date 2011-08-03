From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH v4 0/3] DEVFREQ,
	DVFS framework for non-CPU devices
Date: Wed, 03 Aug 2011 11:33:35 -0700
Message-ID: <87aabq5oqo.fsf@ti.com>
References: <1310717510-19002-1-git-send-email-myungjoo.ham@samsung.com>
	<201107290010.53788.rjw@sisk.pl> <87livba2w6.fsf@ti.com>
	<CAJ0PZbTMn_pzFBWbhtMrMo9ZGsnwMNKENgMSDa=oOZCrGh03Gg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <CAJ0PZbTMn_pzFBWbhtMrMo9ZGsnwMNKENgMSDa=oOZCrGh03Gg@mail.gmail.com>
	(MyungJoo Ham's message of "Wed, 3 Aug 2011 16:03:58 +0900")
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: myungjoo.ham@gmail.com
Cc: Len Brown <len.brown@intel.com>, Greg Kroah-Hartman <gregkh@suse.de>, Kyungmin Park <kyungmin.park@samsung.com>, Thomas Gleixner <tglx@linutronix.de>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

MyungJoo Ham <myungjoo.ham@samsung.com> writes:

> On Wed, Aug 3, 2011 at 7:02 AM, Kevin Hilman <khilman@ti.com> wrote:

[...]

>> Maybe I'm not understanding the usage of it fully, but that seems like
>> hard-coding policy into the framework that might not be appropriate.
>> For example, what if there are other devices with constraints such that
>> they cannot currently scale frequency/voltage?
>>
>> Mabye MyungJoo can explain in more detail the usecases for tickle?
>
> Tickle is not for QoS between devices. It is for faster reaction to
> (human) user inputs at DVFS side where waiting for DVFS's reaction
> takes too much time and reducing polling interval costs too much. 

This is exactly what quality of service (QoS) is about.

The user (whether it's a human user input or another device) has low
quality and expects higher quality.  It wants to request better quality,
so it needs a way to request it.   

The proposed "tickle" approach proposed here is simply a "request max
frequency for duration X" QoS request.

Kevin
