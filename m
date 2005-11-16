From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [RFC] userland swsusp
Date: Wed, 16 Nov 2005 22:41:23 +0100
Message-ID: <200511162241.23667.rjw@sisk.pl>
References: <20051115212942.GA9828@elf.ucw.cz>
	<20051115233201.GA10143@elf.ucw.cz>
	<20051115234007.GO17023@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <20051115234007.GO17023@redhat.com>
Content-Disposition: inline
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Dave Jones <davej@redhat.com>
Cc: Linux-pm mailing list <linux-pm@lists.osdl.org>, kernel list <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

Hi,

On Wednesday, 16 of November 2005 00:40, Dave Jones wrote:
> On Wed, Nov 16, 2005 at 12:32:01AM +0100, Pavel Machek wrote:
> 
>  > If this goes in, you can still keep using old method... I'll not
>  > remove it anytime soon.
> 
> Ok.
> 
>  > > Even it were not for this, the whole idea seems misconcieved to me
>  > > anyway.
>  > 
>  > ...but how do you provide nice, graphical progress bar for swsusp
>  > without this? People want that, and "esc to abort", compression,
>  > encryption. Too much to be done in kernel space, IMNSHO.
>  
> I'll take "rootkit doesnt work" over "bells and whistles".
> 
> I think most users actually care more about "works" than
> "looks pretty, and then fails spectacularly".

I've been discussing this with Pavel for quite some time and my opinion is
that moving the image-writing and reading functionality of swsusp
to the user space makes sense from the technical point of view.

For example it would allow us to add the image encryption (real, eg.
with a passphrase-protected key), image compression, and image
verification in a rather straightforward way.  These are important
functionalities, at least for some users.

However, I think we should not try to read and/or set up kernel
data structures from the users space.  Instead, we can create an interface
that will allow us to convey the image data and metadata from the
kernel to the user space and vice versa.

Greetings,
Rafael
