From: mark gross <markgross@thegnar.org>
Subject: Re: pm loss development
Date: Tue, 17 May 2011 20:12:03 -0700
Message-ID: <20110518031203.GA3640__37741.0828987651$1305688393$gmane$org@gvim.org>
References: <1305220265-9020-1-git-send-email-lamiaposta71@gmail.com>
	<201105131854.57854.rjw@sisk.pl> <20110514163513.GB8292@gvim.org>
	<201105180107.58078.rjw@sisk.pl>
Reply-To: markgross@thegnar.org
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <201105180107.58078.rjw@sisk.pl>
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
Cc: linux-kernel@vger.kernel.org, linux-pm@lists.linux-foundation.org, davinci-linux-open-source@linux.davincidsp.com, Raffaele Recalcati <lamiaposta71@gmail.com>, markgross@thegnar.org
List-Id: linux-pm@vger.kernel.org

On Wed, May 18, 2011 at 01:07:57AM +0200, Rafael J. Wysocki wrote:
> On Saturday, May 14, 2011, mark gross wrote:
> > On Fri, May 13, 2011 at 06:54:57PM +0200, Rafael J. Wysocki wrote:
> > > On Friday, May 13, 2011, Raffaele Recalcati wrote:
> > > > Hi Rafael,
> > > > 
> > > > 2011/5/12 Rafael J. Wysocki <rjw@sisk.pl>:
> > > > > On Thursday, May 12, 2011, Raffaele Recalcati wrote:
> > > > >> What happen normally in runtime pm implementation is that every devices
> > > > >> are switched off and are enabled only when needed.
> > > > >> In our case instead we have a completely functional embedded system and,
> > > > >> when an asyncrhonous event appear, we have only some tens milliseconds
> > > > >> before the actual power failure takes place.
> > > > >> This patchset add a support in order to switch off not vital part of the system,
> > > > >> in order to allow the board to survive longer.
> > > > >> This allow the possibility to save important data.
> > > > >
> > > > > OK, so first, who decides what parts of the system are vital and what aren't?
> > > > 
> > > > Take a quick look at Documentation/power/loss.txt  paragrpah "2.4
> > > > Power loss policies".
> > > > You can decide what can be powered off.
> > > 
> > > I read the patches.  My question was about the general idea of who should
> > > be responsible of making these decisions.
> > 
> > I would expect the system integrator would based on the application the
> > device is getting deployed into.
> > 
> > A generic opportunistic policy for peripherals that are stateless and can
> > be trivially power gated off/on from an ISR could be a default but, for
> > peripherals that need to do some processing (like waiting on an eMMC DMA
> > to complete) can take time to power down into a safe state.
> 
> What do you mean by safe state?
>
I need to get more details on this but I assume its a state where the
meta data of the file system is committed to the emmc before lights go
off such that when power is reapplied that the damage isn't too big. 

I've also heard some talk of sim card corruption risks but, I don't have
first hand info on that.

--mark
