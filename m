From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: Suspend, followed by immediate resume
Date: Fri, 2 May 2008 12:47:54 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0805021246470.12185-100000@iolanthe.rowland.org>
References: <20080502113927.49f31af9@osprey.hogchain.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20080502113927.49f31af9@osprey.hogchain.net>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Jay Cliburn <jacliburn@bellsouth.net>
Cc: linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Fri, 2 May 2008, Jay Cliburn wrote:

> On Fri, 2 May 2008 11:00:26 -0400 (EDT)
> Alan Stern <stern@rowland.harvard.edu> wrote:
> 
> > On Thu, 1 May 2008, Jay Cliburn wrote:
> > 
> > > I'm trying to get wake-on-lan working on the network driver I
> > > maintain (atl1), but I can't get my system to suspend to memory
> > > long enough to test it.  Seems that my system suspends and
> > > immediately wakes up again without any intervention on my part.
> 
> > Have you tried unplugging your USB mouse before suspending?
> 
> I installed a USB-PS2 adapter for the mouse and rebooted.  No help;
> still suspends and immediately resumes.  (There are now no external USB
> devices connected to the system.)
> 
> Your question made me realize though that I'd left out a potentially
> important piece of information in my initial report: this is a desktop
> system.  Not sure if that matters.

Another thing you can try is to unload as many kernel modules as 
possible before suspending.  Maybe one of them will turn out to be the 
trigger for the immediate resumes.

Alan Stern
