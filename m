From: Arjan van de Ven <arjan@infradead.org>
Subject: Re: pm qos infrastructure and interface
Date: Thu, 11 Oct 2007 08:38:27 -0700
Message-ID: <20071011083827.3b964620__18973.6309614547$1192133093$gmane$org@laptopd505.fenrus.org>
References: <20071004215139.GA20078@linux.intel.com>
	<20071010221704.6e438c71.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20071010221704.6e438c71.akpm@linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: torvalds@linux-foundation.org, linux-pm@lists.linux-foundation.org, linux-kernel@vger.kernel.org, mark.gross@intel.com
List-Id: linux-pm@vger.kernel.org

On Wed, 10 Oct 2007 22:17:04 -0700
Andrew Morton <akpm@linux-foundation.org> wrote:

> I'm a bit surprised that this change appears to have no
> configurability. If one has set CONFIG_PM=n (for example), shouldn't
> it all go away?

I suppose it's a matter of taste, but at least personally I believe that
userspace exposed ABI's shouldn't be configurable as a starting point
(if the code delta is 100's of kilobytes it's a different topic); what
point is talking about a stable ABI if it's there or not half the
time... that's the ultimate instability.
