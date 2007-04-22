From: Len Brown <lenb@kernel.org>
Subject: Re: [patch 2.6.21-rc7] kconfig mentioneds 'hibernation'
	not just swsusp
Date: Sat, 21 Apr 2007 23:21:02 -0400
Message-ID: <200704212321.02822.lenb@kernel.org>
References: <200704212002.59554.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200704212002.59554.david-b@pacbell.net>
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
To: linux-pm@lists.linux-foundation.org
Cc: Andrew Morton <akpm@linux-foundation.org>, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org


>  	  In principle it does not require ACPI or APM, although for example
> -	  ACPI will be used if available.
> +	  ACPI will be used for the final steps when it is available.  One
> +	  of the reasons to use software suspend is that the firmware hooks
> +	  for suspend states like suspend-to-RAM (STR) often don't work very
> +	  well with Linux.

I don't think the help section of a config options
is a good place for editorial.

-Len
