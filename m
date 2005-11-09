From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [RFC/RFT][PATCH 2/2] swsusp: improve freeing of
	memory
Date: Wed, 9 Nov 2005 15:46:47 +0100
Message-ID: <20051109144647.GA1909@elf.ucw.cz>
References: <200511082355.43984.rjw@sisk.pl> <200511090011.53125.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============96731847386343173=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <200511090011.53125.rjw@sisk.pl>
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
Cc: Linux PM <linux-pm@osdl.org>
List-Id: linux-pm@vger.kernel.org

--===============96731847386343173==
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!

> This patch makes swsusp free only as much memory as needed and not as much
> as possible.

Is there a way to get old behaviour (== free as much memory as
possible)? For console users, it may be preferable...

							Pavel
-- 
Thanks, Sharp!

--===============96731847386343173==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============96731847386343173==--
