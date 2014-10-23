From: Borislav Petkov <bp@alien8.de>
Subject: Re: lockdep splat in CPU hotplug
Date: Thu, 23 Oct 2014 10:11:25 +0200
Message-ID: <20141023081125.GA4643@pd.tnic>
References: <alpine.LNX.2.00.1410211255531.24255@pobox.suse.cz>
 <alpine.LNX.2.00.1410221125280.22681@pobox.suse.cz>
 <20141022143837.GW4977@linux.vnet.ibm.com>
 <20141022165433.GA22874@linux.vnet.ibm.com>
 <20141022185712.GA9570@linux.vnet.ibm.com>
 <alpine.LNX.2.00.1410222255540.17725@pobox.suse.cz>
 <20141022210943.GL4977@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20141022210943.GL4977@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc: Jiri Kosina <jkosina@suse.cz>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Pavel Machek <pavel@ucw.cz>, Steven Rostedt <rostedt@goodmis.org>, Dave Jones <davej@redhat.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Nicolas Pitre <nico@linaro.org>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Wed, Oct 22, 2014 at 02:09:43PM -0700, Paul E. McKenney wrote:
> > Yes, this works. FWIW, please feel free to add 
> > 
> > 	Reported-and-tested-by: Jiri Kosina <jkosina@suse.cz>
> > 
> > once merging it.
> 
> Done, and thank you for both the bug report and the testing!

Works here too.

Tested-by: Borislav Petkov <bp@suse.de>

Thanks.

-- 
Regards/Gruss,
    Boris.

Sent from a fat crate under my desk. Formatting is fine.
--
