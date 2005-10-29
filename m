From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [RFC][PATCH 0/6] swsusp: rework swap handling
Date: Sun, 30 Oct 2005 01:05:15 +0200
Message-ID: <20051029230515.GE14209@elf.ucw.cz>
References: <200510292158.11089.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============40467570062685471=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <200510292158.11089.rjw@sisk.pl>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linux-pm@osdl.org, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

--===============40467570062685471==
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!

> I have divided the changes into some more or less logical steps for clarity.
> Although the code has been designed as proof-of-concept, it is functional
> and has been tested on x86-64, except for the cryptographic functionality
> and error paths.

Don't worry about crypto paths too much. It is my fault, I should not
have taken them in the first place. Just ask ast for testing when you
are reasonably confident it will work.
								Pavel
-- 
Thanks, Sharp!

--===============40467570062685471==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============40467570062685471==--
