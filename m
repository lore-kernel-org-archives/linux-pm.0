From: Pavel Machek <pavel@ucw.cz>
Subject: Re: Re: [linux-usb-devel] Fwd: USB suspending
Date: Thu, 11 Oct 2007 18:13:39 +0000
Message-ID: <20071011181339.GB3868@ucw.cz>
References: <200710051559.43771.oliver@neukum.org>
	<Pine.LNX.4.44L0.0710051117560.4446-100000@iolanthe.rowland.org>
	<20071005163518.GA2389@ics.muni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20071005163518.GA2389@ics.muni.cz>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Lukas Hejtmanek <xhejtman@ics.muni.cz>
Cc: pm list <linux-pm@lists.linux-foundation.org>, linux-usb-devel@lists.sourceforge.net
List-Id: linux-pm@vger.kernel.org

On Fri 2007-10-05 18:35:18, Lukas Hejtmanek wrote:
> On Fri, Oct 05, 2007 at 11:25:11AM -0400, Alan Stern wrote:
> > > But power consumption on these ports is minimal for suspended devices,
> > > so it is a bad idea.
> > 
> > Right.  Power consumption is even smaller on ports with no devices 
> > plugged in.
> 
> For example, IBM ThinkPad T60 powers off all USB ports when hcd-uhci module is
> unloaded. My ASUS M6A does not, it does not also in Windows XP though. 
> 
> I still wonder why suspended machine consumes about 2Wh in S-T-R while the IBM
> consumes about 0.2Wh.

Video card?

Leave machine sleeping for a while, then open it and search for warm
components...?
							Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
