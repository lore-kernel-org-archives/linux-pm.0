From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH -mm] x86_64: Save registers in saved_context
 during suspend and hibernation
Date: Fri, 17 Aug 2007 14:08:20 -0700
Message-ID: <20070817140820.63c22071.akpm__3958.73303427852$1187385046$gmane$org@linux-foundation.org>
References: <200708171526.23250.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200708171526.23250.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: pm list <linux-pm@lists.linux-foundation.org>, Pavel@smtp2.linux-foundation.org, Andi Kleen <ak@suse.de>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Fri, 17 Aug 2007 15:26:22 +0200
"Rafael J. Wysocki" <rjw@sisk.pl> wrote:

> During hibernation and suspend on x86_64 save CPU registers in the saved_context
> structure rather than in a handful of separate variables.

You have "-mm" in the subject but afaict this patch is not dependent upon
anything in -mm?
