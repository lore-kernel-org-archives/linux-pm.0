From: "Jordan Crouse" <jordan.crouse@amd.com>
Subject: Re: Toward runtime power management in Linux
Date: Mon, 1 Aug 2005 09:10:23 -0600
Message-ID: <20050801151023.GA12097@cosmic.amd.com>
References: <20050801021054.GA30859@best.com>
	<Pine.LNX.4.44L0.0508010935440.4961-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============85010421471580866=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <Pine.LNX.4.44L0.0508010935440.4961-100000@iolanthe.rowland.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

--===============85010421471580866==
Content-Type: text/plain;
 charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

> > 	This could potentially make performance-conscious apps "hiccup"
> > once every second as this thread goes walking the list looking for
> > candidates to shut off.  Try to avoid this; if nothing is happening, nothing
> > should be running.
> 
> I don't understand this comment at all.  Lots of things happen 
> periodically in the kernel: threads wake up, timers go off...  Are you 
> suggesting that, for example, the page-flush thread shouldn't wake up 
> from time to time either?

While I don't agree that it will be a horrible drain on performance, I do
see a large potential for abuse with a big kernel thread.  Things like the
page-flush thread are well known and (hopefully) optimized entities -
the RTPM thread will have to depend on hundreds of driver writers to be kind
to not suck time and resources from the system.  About the time that somebody
puts a large udelay into their AC97 driver to turn off the DAC, then I'm sure
we will question our motives in this regard.

That said, I think I tend to favor the big kernel thread, or at least timeout
threads on a bus level.  The single entity handling the idle math timeout
would facilitate future issues such as priority in handling idle timeouts 
(do we address certain buses/devices before others, for example), plus it
would help centralize the functionality, and make it easier to control with
any future power management policy concepts.

Jordan

-- 
Jordan Crouse
Senior Linux Engineer
AMD - Personal Connectivity Solutions Group
<www.amd.com/embeddedprocessors>


--===============85010421471580866==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============85010421471580866==--
