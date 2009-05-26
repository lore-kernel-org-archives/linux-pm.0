From: Nigel Cunningham <nigel@tuxonice.net>
Subject: Re: [TuxOnIce-devel] [RFC] TuxOnIce
Date: Wed, 27 May 2009 09:59:26 +1000
Message-ID: <1243382366.13930.105.camel__43815.5051241212$1243382365$gmane$org@nigel-laptop>
References: <Pine.LNX.4.44L0.0905261754250.11998-100000@iolanthe.rowland.org>
Reply-To: nigel@tuxonice.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.0905261754250.11998-100000@iolanthe.rowland.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: linux-pm@lists.linux-foundation.org, tuxonice-devel@lists.tuxonice.net, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Hi.

On Tue, 2009-05-26 at 17:56 -0400, Alan Stern wrote:
> On Wed, 27 May 2009, Nigel Cunningham wrote:
> 
> > USB devices ought to be able to do _something_ though - I have a Dvico
> > Dual Digital 4 card
> 
> What is that?

It's a dual digital TV tuner that includes an IR receiver. It plugs into
a PCI slot, but registers two USB devices and an input driver.

> > that is forcing me to shutdown X, mythtv-backend,
> > pulse audio and lirc at the moment so that I can rmmod it while
> > hibernating. That ought not be necessary. I'm sure there are good
> > technical reasons why it is necessary at the mooment, but it shouldn't
> > be that way - even if it just does the bare minimum required to avoid
> > requiring the closing of files and the unload.
> 
> Probably the driver's author just never got around to adding support
> for suspend/resume.  Which driver is it?  What happens if you don't 
> rmmod it?

The hard drive on that box died on me and I'm just about to install a
new one so I can only say from memory right now. I think I'd better wait
until I do the reinstall before I say too much. I do believe you're
right though - I took a brief look and think there was no suspend or
resume support.

I'll get back to you as soon as I have more info - thanks for taking an
interest!

Regards,

Nigel
