From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: Re: Toward runtime power management in Linux
Date: Mon, 1 Aug 2005 11:23:10 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0508011119080.4961-100000@iolanthe.rowland.org>
References: <20050801151023.GA12097@cosmic.amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============034303735940496516=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <20050801151023.GA12097@cosmic.amd.com>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Jordan Crouse <jordan.crouse@amd.com>
Cc: linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

--===============034303735940496516==
Content-Type: TEXT/PLAIN; charset=US-ASCII

On Mon, 1 Aug 2005, Jordan Crouse wrote:

> While I don't agree that it will be a horrible drain on performance, I do
> see a large potential for abuse with a big kernel thread.  Things like the
> page-flush thread are well known and (hopefully) optimized entities -
> the RTPM thread will have to depend on hundreds of driver writers to be kind
> to not suck time and resources from the system.  About the time that somebody
> puts a large udelay into their AC97 driver to turn off the DAC, then I'm sure
> we will question our motives in this regard.

Hmmm...  A large delay in a suspend pathway will cause problems no matter 
how it gets invoked, right?  If we have a separate kernel thread for RTPM, 
then at least the only things affected will be other RTPM activities.  
Whereas if we use keventd instead to provide a process context, lots of 
other things would be affected as well.

> That said, I think I tend to favor the big kernel thread, or at least timeout
> threads on a bus level.  The single entity handling the idle math timeout
> would facilitate future issues such as priority in handling idle timeouts 
> (do we address certain buses/devices before others, for example), plus it
> would help centralize the functionality, and make it easier to control with
> any future power management policy concepts.

Those are good ideas.

Alan Stern


--===============034303735940496516==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============034303735940496516==--
