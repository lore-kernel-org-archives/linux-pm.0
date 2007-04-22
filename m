From: David Brownell <david-b@pacbell.net>
Subject: Re: [patch 2.6.21-rc7] kconfig mentions 'hibernation' not
	just swsusp
Date: Sat, 21 Apr 2007 20:50:56 -0700
Message-ID: <200704212050.57086.david-b@pacbell.net>
References: <200704212002.59554.david-b@pacbell.net>
	<200704212321.02822.lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200704212321.02822.lenb@kernel.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Len Brown <lenb@kernel.org>
Cc: linux-pm@lists.linux-foundation.org, Andrew Morton <akpm@linux-foundation.org>, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

On Saturday 21 April 2007, Len Brown wrote:
> 
> >  	  In principle it does not require ACPI or APM, although for example
> > -	  ACPI will be used if available.
> > +	  ACPI will be used for the final steps when it is available.  One
> > +	  of the reasons to use software suspend is that the firmware hooks
> > +	  for suspend states like suspend-to-RAM (STR) often don't work very
> > +	  well with Linux.
> 
> I don't think the help section of a config options
> is a good place for editorial.

That doesn't seem "editorial" to me though.  It's a basic
engineering truth that's repeatedly been borne out over many,
many years.  The point of help text in Kconfig is, to my
thought, to help people understand why to choose something
(or not); knowing that firmware hooks (not purely ACPI) are
a factor would seem to be such help.

If I'd wanted to be "editorial", I'd have said something
more like:

	It's too bad chip vendors' video support for S2RAM
	still sucks so badly, and hardly looks to improve,
	since ACPI has improved so much in recent kernels.

	Today the "standby" suspend state works with Linux
	on most systems that support it, as does the "disk"
	(software suspend) state.   But suspend to "mem" is
	what most people want, since it's a lot quieter (and
	more power efficient) than "standby", and comes back
	a lot quicker than "disk".

	Until vendors of graphics silicon start providing
	enough chip specs to let Linux systems reliably
	restart graphics after suspend-to-RAM, anyone who
	wants to us suspend-to-RAM is advised to be VERY
	selective about video card support.  Choose only
	among the following video devices:  <insert short
	list here ... who should be on it??>

See the difference?  :)

... and yes, there are other drivers that may need tweaks to
work better with STR, but video has been the forever-headache.

- Dave
