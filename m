From: David Brownell <david-b@pacbell.net>
Subject: Re: [RFC] Disabling Devices
Date: Wed, 11 May 2005 07:04:40 -0700
Message-ID: <200505110704.40587.david-b@pacbell.net>
References: <Pine.LNX.4.44L0.0505091350020.5866-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============36723655596008875=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <Pine.LNX.4.44L0.0505091350020.5866-100000@iolanthe.rowland.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Linux-pm mailing list <linux-pm@lists.osdl.org>
List-Id: linux-pm@vger.kernel.org

--===============36723655596008875==
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Monday 09 May 2005 11:06 am, Alan Stern wrote:
> There's an issue here that needs to be discussed explicitly.  How finely
> should the kernel allow userspace to control runtime power management?
> 
> ...
>     (B) Or should the kernel export a relatively small set of power 
> 	domains and a small set of primitives for each domain?  Like:
> 	suspend, turn off remote wakeup, go to full power, suspend
> 	after N seconds of inactivity?
> 
> ...
> 
> In general (A) most resembles what sysfs does right now.  I suspect that 
> (B) will be a better solution in the end.

Yes.


> Regarding Dave's comments about hdparm and xset dpms -- what matters most 
> about these interfaces is not that they are application-specific but that 
> they are ad-hoc. 

How does "application-specific" differ from "ad-hoc" though?
In practical terms; one is more pejorative than the other, but
how exactly does one measure a difference?

For example, the kernel doesn't know about X11 protocol at all,
or those particular IDE protocol requests.  And most folk would
probably say that it shouldn't need to ...


> I don't see why we can't strive to present a much more  
> uniform interface, even if it does describe widely varying subsystems.  I 
> also don't see anything wrong with implementing this interface by means of 
> sysfs instead of using driver-specific ioctls.

For new things, or things being generalized into kernel support,
I've no fundamental issue with using sysfs.  But for things that
are widely deployed today, I don't see much point in changing
interfaces.

- Dave

--===============36723655596008875==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============36723655596008875==--
