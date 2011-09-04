From: Oleg Nesterov <oleg@redhat.com>
Subject: Re: [PATCHSET pm-freezer] freezer: fixes &
	simplifications
Date: Sun, 4 Sep 2011 20:48:09 +0200
Message-ID: <20110904184809.GA30989__44405.0058526502$1315162336$gmane$org@redhat.com>
References: <1314988070-12244-1-git-send-email-tj@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1314988070-12244-1-git-send-email-tj@kernel.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Tejun Heo <tj@kernel.org>
Cc: containers@lists.linux-foundation.org, linux-kernel@vger.kernel.org, linux-pm@lists.linux-foundation.org, paul@paulmenage.org
List-Id: linux-pm@vger.kernel.org

On 09/03, Tejun Heo wrote:
>
> These six patches are fixes and simplifications for the recent freezer
> changes.  The first four have been posted twice.  Changes since the
> last posting[L] are
>
> * freezer->state setting bug fix updated per Matt Helsley so that the
>   actual per-task freeze/thaw operations are always performed.
>
> * fixed a bug caused by forgetting to unlock freezer_lock in "freezer:
>   restructure __refrigerator()".
>
> * Two patches added.  The fifth one is mostly trivial.  The sixth a
>   bit more involved but still shouldn't cause any noticeable
>   functional difference.  This removes the buggy and unused
>   freezable_with_signal.

Afaics, everything is fine.

Oleg.
