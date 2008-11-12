From: Jesse Barnes <jbarnes@virtuousgeek.org>
Subject: Re: Suspend to disk broken in latest 2.6.28-rc3
Date: Wed, 12 Nov 2008 10:33:58 -0800
Message-ID: <200811121033.58840.jbarnes__39653.2364924953$1226515251$gmane$org@virtuousgeek.org>
References: <20081109195033.GA1335@mobydick> <20081110231524.GA18971@mobydick>
	<20081111152736.GA28569@mobydick>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20081111152736.GA28569@mobydick>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Mathieu Chouquet-Stringer <mchouque@free.fr>
Cc: linux-kernel@vger.kernel.org, Pavel Machek <pavel@suse.cz>, Alex Deucher <alexdeucher@gmail.com>, Dave Airlie <airlied@redhat.com>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Tuesday, November 11, 2008 7:27 am Mathieu Chouquet-Stringer wrote:
> On Tue, Nov 11, 2008 at 12:15:24AM +0100, Mathieu Chouquet-Stringer wrote:
> > This one I guess:
> > http://bugzilla.kernel.org/attachment.cgi?id=18644&action=view
> >
> > Let me give it a shot, I'll keep you posted.
>
> So I compiled the module, rebooted just to have a clean starting point,
> started X then tried to suspend: no go...

Dave pushed a fix for this (more complete than the one in the patch you 
reference), have you tried the kernel from today to see if things work now?

Thanks,
Jesse
