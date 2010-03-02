From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [Bug 15289] Regression 2.6.32 -> 2.6.33,
 Kernel needs a helping key to boot :)
Date: Tue, 2 Mar 2010 13:04:18 +0100 (CET)
Message-ID: <alpine.LFD.2.00.1003021302360.4245__23350.2483032227$1267531689$gmane$org@localhost.localdomain>
References: <bug-15289-10028@http.bugzilla.kernel.org/>
	<201003010617.o216HBix024914@demeter.kernel.org>
	<201003012103.00609.rjw@sisk.pl>
	<alpine.LFD.2.00.1003012114470.4245@localhost.localdomain>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323328-377522668-1267531460=:4245"
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <alpine.LFD.2.00.1003012114470.4245@localhost.localdomain>
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
Cc: Andreas Herrmann <andreas.herrmann3@amd.com>, bugzilla-daemon@bugzilla.kernel.org, LKML <linux-kernel@vger.kernel.org>, =?ISO-8859-15?Q?Asbj=F8rn_Sannes?= <kernelbugzilla@sannes.org>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-377522668-1267531460=:4245
Content-Type: TEXT/PLAIN; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by smtp1.linux-foundation.org id o22C5iJd015917

Asbj=C3=B8rn,

can you please run the following tests and report the results ?

1) Add "maxcpus=3D1" to the kernel command line

2) Add "nomsi" to the kernel command line

Thanks,

	tglx
--8323328-377522668-1267531460=:4245
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 7bit


--8323328-377522668-1267531460=:4245--
