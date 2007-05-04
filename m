From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Hibernation and suspend patchset
Date: Fri, 4 May 2007 14:15:45 +0200
Message-ID: <200705041415.45773.rjw@sisk.pl>
References: <200705011558.11170.rjw@sisk.pl> <200705041402.40964.rjw@sisk.pl>
	<1178280352.7408.15.camel@johannes.berg>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1178280352.7408.15.camel@johannes.berg>
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
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Pekka Enberg <penberg@cs.helsinki.fi>, pm list <linux-pm@lists.linux-foundation.org>, Nigel Cunningham <nigel@nigel.suspend2.net>, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

On Friday, 4 May 2007 14:05, Johannes Berg wrote:
> Hi,
> 
> > These #includes are added by
> > 
> > 008-add-try_to_freeze-everywhere.patch
> > 
> > Perhaps it's one of the patches that don't apply to the current -git?
> 
> Hmm, could be, but shouldn't the patch that adds the freezer_exempt
> calls add them as well?

Well, I'm not sure what you mean.  It's on top of
008-add-try_to_freeze-everywhere.patch and the #includes are already there, so
it can't just add them once again.

IOW, the ordering of patches in the patchset is important and if you drop one,
you may need to replace it with another patch that does similar changes.

Greetings,
Rafael
