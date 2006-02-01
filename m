From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [RFC][PATCH -mm][Experimental] swsusp: freeze
	userspace processes first
Date: Wed, 1 Feb 2006 11:55:05 +0100
Message-ID: <20060201105505.GB2879@elf.ucw.cz>
References: <200602010141.53974.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============21914194991421843=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <200602010141.53974.rjw@sisk.pl>
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
Cc: Nigel Cunningham <nigel@suspend2.net>, Linux PM <linux-pm@osdl.org>
List-Id: linux-pm@vger.kernel.org

--===============21914194991421843==
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!

> This is an experimantal patch aimed at the "unable to freeze processes under
> load" problem.
> 
> On my box the 2.6.16-rc1-mm4 kernel with this patch applied survives the
> "dd if=/dev/hda of=/dev/null" test.

What filesystem? ext2 vs. ext3 is very different. I can fix ext2 by
just upping the timeout. ext3 is harder, because of the journalling
thread. Maybe I'll take the sledgehammer approach and just freeze all
the user tasks first... I tried to do the "small" approach and just
fix the journalling code...

I'm not sure what problem the usermodehelper code is trying to
solve... why are usermodehelpers special?
								Pavel


-- 
Thanks, Sharp!

--===============21914194991421843==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============21914194991421843==--
