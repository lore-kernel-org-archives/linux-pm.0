From: Dave Jones <davej@redhat.com>
Subject: Re: [RFC] userland swsusp
Date: Tue, 15 Nov 2005 18:40:07 -0500
Message-ID: <20051115234007.GO17023@redhat.com>
References: <20051115212942.GA9828@elf.ucw.cz>
	<20051115222549.GF17023@redhat.com>
	<20051115233201.GA10143@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============25785901316227644=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <20051115233201.GA10143@elf.ucw.cz>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Linux-pm mailing list <linux-pm@lists.osdl.org>, kernel list <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

--===============25785901316227644==
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Nov 16, 2005 at 12:32:01AM +0100, Pavel Machek wrote:

 > If this goes in, you can still keep using old method... I'll not
 > remove it anytime soon.

Ok.

 > > Even it were not for this, the whole idea seems misconcieved to me
 > > anyway.
 > 
 > ...but how do you provide nice, graphical progress bar for swsusp
 > without this? People want that, and "esc to abort", compression,
 > encryption. Too much to be done in kernel space, IMNSHO.
 
I'll take "rootkit doesnt work" over "bells and whistles".

I think most users actually care more about "works" than
"looks pretty, and then fails spectacularly".

		Dave


--===============25785901316227644==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============25785901316227644==--
