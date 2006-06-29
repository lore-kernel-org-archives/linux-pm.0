From: "Gross, Mark" <mark.gross@intel.com>
Subject: Re: [PATCH 2/2] Fix console handling duringsuspend/resume
Date: Thu, 29 Jun 2006 13:13:03 -0700
Message-ID: <5389061B65D50446B1783B97DFDB392D019DE2D5@orsmsx411.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
Content-class: urn:content-classes:message
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Linus Torvalds <torvalds@osdl.org>, Greg KH <greg@kroah.com>
Cc: David Brownell <david-b@pacbell.net>, linux-pm@lists.osdl.org, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org



>-----Original Message-----
>From: linux-pm-bounces@lists.osdl.org
[mailto:linux-pm-bounces@lists.osdl.org] On Behalf Of Linus
>Torvalds
>Sent: Wednesday, June 28, 2006 8:24 PM
>To: Greg KH
>Cc: David Brownell; linux-pm@lists.osdl.org; Pavel Machek
>Subject: Re: [linux-pm] [PATCH 2/2] Fix console handling
duringsuspend/resume
>
>
>
>On Wed, 28 Jun 2006, Greg KH wrote:
>>
>> Any thoughts as to applying your patch to the tree or not?  No
objection
>> from me if you want to.
>
>I've not actually had anybody report any testing success from it, and
>since I don't use suspend-to-disk, for example, if would be good to
have
>verification.
>
>AS FAR AS I CAN TELL the patch won't actually change any behaviour (I
have
>actually been running for the last few days with the separate patch
that
>_does_ do that - moves the PCI config suspend/resume to the late/early
>rsume phase), but hey, mistakes happen.
>

Shouldn't this type of thing go through the MM-tree first for these
reasons?


--mgross
