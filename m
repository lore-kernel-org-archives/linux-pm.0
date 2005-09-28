From: Pavel Machek <pavel@ucw.cz>
Subject: Re: Problems with PM_FREEZE
Date: Wed, 28 Sep 2005 15:03:01 +0200
Message-ID: <20050928130301.GA2118@elf.ucw.cz>
References: <1127863145.4802.40.camel@localhost>
	<Pine.LNX.4.44L0.0509272236580.15378-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============27206377090472733=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <Pine.LNX.4.44L0.0509272236580.15378-100000@netrider.rowland.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Nigel Cunningham <ncunningham@cyclades.com>, Linux-pm mailing list <linux-pm@lists.osdl.org>
List-Id: linux-pm@vger.kernel.org

--===============27206377090472733==
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!

> 	(B) tell the image kernel that it is resuming from disk, so
> 	that it can know that the devices are really suspended even
> 	though its internal records say they are frozen.

Feel free to submit a patch. We have talked about this before, and the
patch will be rather big, touching most of the kernel. You want it,
then you do it.
								Pavel

-- 
if you have sharp zaurus hardware you don't need... you know my address

--===============27206377090472733==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============27206377090472733==--
