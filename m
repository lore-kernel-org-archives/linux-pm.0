From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH] Don't explode on swsusp failure to find swap
Date: Tue, 31 May 2005 12:36:26 +0200
Message-ID: <20050531103623.GB1848@elf.ucw.cz>
References: <1117523585.5826.18.camel@gaston>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============90485904439671139=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <1117523585.5826.18.camel@gaston>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Linux-pm mailing list <linux-pm@lists.osdl.org>, Linux Kernel list <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

--===============90485904439671139==
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!

> If we specify a swap device for swsusp using resume= kernel argument and
> that device doesn't exist in the swap list, we end up calling
> swsusp_free() before we have allocated pagedir_save. That causes us to
> explode when trying to free it.
> 
> Pavel, does that look right ?

It looks like a workaround. We should not call swsusp_free in case
device does not exists. Quick look did not reveal where the bug comes
from, can you try to trace it?
								Pavel

--===============90485904439671139==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============90485904439671139==--
