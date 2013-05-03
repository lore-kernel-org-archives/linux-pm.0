From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH v2 03/10] freezer: add new freezable helpers using
 freezer_do_not_count()
Date: Thu, 2 May 2013 17:03:58 -0700
Message-ID: <20130503000358.GX19814@mtj.dyndns.org>
References: <1367458508-9133-1-git-send-email-ccross@android.com>
 <1367458508-9133-4-git-send-email-ccross@android.com>
 <20130502235505.GW19814@mtj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20130502235505.GW19814@mtj.dyndns.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Colin Cross <ccross@android.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>, arve@android.com, Oleg Nesterov <oleg@redhat.com>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Jeff Layton <jlayton@redhat.com>
List-Id: linux-pm@vger.kernel.org

On Thu, May 02, 2013 at 04:55:05PM -0700, Tejun Heo wrote:
> So, the freezable interface can't be something that people can use
> casually.  It is something which should be carefully and strategically
> deployed where we *know* that lock dependency risks don't exist or at
> least are acceptable.  I'm a bit weary that this patch is expanding
> the interface a lot that they now look like the equivalents of normal
> schedule calls.  Not exactly sure what to do here but can we please at
> least have RED BOLD BLINKING comments which scream to people not to
> use these unless they know what they're doing?

Maybe we should trigger WARN_ON_ONCE() if lockdep_depth() > 0 by
default and have ugly variants which can be used if the caller is sure
that it's okay possibly with list of locks which are held?

-- 
tejun
