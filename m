From: David Brownell <david-b@pacbell.net>
Subject: Re: Suspended devices and drivers
Date: Sun, 11 Sep 2005 14:42:47 -0700
Message-ID: <20050911214247.4523BE9DF9@adsl-69-107-32-110.dsl.pltn13.pacbell.net>
References: <Pine.LNX.4.44L0.0509111507420.9186-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0019054809530691941=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <Pine.LNX.4.44L0.0509111507420.9186-100000@netrider.rowland.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: stern@rowland.harvard.edu
Cc: linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

--===============0019054809530691941==
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

> > I'm saying that the *HARDWARE* absolutely did tell ... but Windows
> > discarded that information, creating the inconsistency I highlighted.
>
> What do you mean?  _How_ was the hardware able to tell (considering that
> the computer was powered off at the time) that I had unplugged and
> replugged the device?

The power session was lost, that root hub port was reset.


> If we're going to be careful about use of words, then "unplug" and
> "replug" should refer to physical actions taken on cables and connectors.  
> What you seem to have in mind could better be described as "breaking and
> restoring connectivity", or even "interrupting and restoring Vbus power".

The latter, since that's what's testable.

- Dave


--===============0019054809530691941==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============0019054809530691941==--
