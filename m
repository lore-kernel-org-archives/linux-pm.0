From: Theodore Tso <tytso@mit.edu>
Subject: Re: Massive ext4 filesystem corruption after a failed
	s2disk/ram	cycle
Date: Tue, 6 Oct 2009 17:42:14 -0400
Message-ID: <20091006214214.GC17883@mit.edu>
References: <1254863215.11577.23.camel@maxim-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1254863215.11577.23.camel@maxim-laptop>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Maxim Levitsky <maximlevitsky@gmail.com>
Cc: linux-pm <linux-pm@lists.linux-foundation.org>, linux-kernel <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Tue, Oct 06, 2009 at 11:06:55PM +0200, Maxim Levitsky wrote:
> 
> Just prior to 2.6.32 cycle I tried -next tree and noticed that after a
> failed s2ram (here it works only once, and I test once in a whileto see
> if fixed accidentally) I got a minor filesystem corruption. I am sorry I
> didn't report that back then.

When you say filesystem corruption, it's important to indicate whether
you meant that (a) you noticed that some files were had corrupted
contents, (b) the kernel complained that the filesystem was corrupted,
and remounted the filesystem read-only, or (c) e2fsck found and fixed
errors.

Also, when you found errors of either class (a) or (b), did you run
e2fsck to find and fix any potential errors?  In a few places it
sounded like the kernel had complained about errors, but you had
ignored them and hadn't run e2fsck to fix them.  I hope that was just
me misunderstanding what you wrote!  Can you clarify?

   		    	     	     	     - Ted
