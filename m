From: David Brownell <david-b@pacbell.net>
Subject: Re: RE: on-ness
Date: Fri, 21 Apr 2006 10:15:39 -0700
Message-ID: <200604211015.40097.david-b@pacbell.net>
References: <CFF307C98FEABE47A452B27C06B85BB63590D8@hdsmsx411.amr.corp.intel.com>
	<20060420132542.GA2668@ucw.cz>
	<200604210827.33274.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============28004632687083486=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <200604210827.33274.david-b@pacbell.net>
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
Cc: Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

--===============28004632687083486==
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Friday 21 April 2006 8:27 am, David Brownell wrote:

> 	  And especially for PM, many driver writers are lazy.

Let me update that.  The issue is less that the driver writers
are lazy, and more that the system PM infrastructure tends to not
work well on PCs, given issues with BIOS/ACPI/... and the Linux
code that talks to it.

In my own case, I don't even own a PC any more where Linux PM will
properly enter and exit (!!) true power-managed states like "standby"
or "suspend-to-RAM".  So there is very little point in putting effort
into driver PM test/debug, beyond the basic test-through-sysfs stuff
(which may not suffice to shake loose bugs in STR paths etc).

On those rare platforms where Linux system infrastructure handles
power sanely -- including letting drivers get information about
the target system state, so suspend() can be smart enough -- the
only real issue with PM is testing.  And that's no harder than any
other thing driver writers do; it can often be easier, in fact.

- Dave


--===============28004632687083486==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============28004632687083486==--
