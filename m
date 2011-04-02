From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 16/18] 2.6.40: x86 idle APM: remove
 deprecated apm_cpu_idle()
Date: Sat, 2 Apr 2011 12:40:54 +0100
Message-ID: <20110402124054.49c3a3f4__997.459473046724$1301744467$gmane$org@lxorguk.ukuu.org.uk>
References: <alpine.LFD.2.02.1104010020280.2797@x980>
	<1301725380-10579-1-git-send-email-lenb@kernel.org>
	<5d9716021b20302ece48fd486bbad9bcb2502353.1301724243.git.len.brown@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <5d9716021b20302ece48fd486bbad9bcb2502353.1301724243.git.len.brown@intel.com>
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
Cc: Len Brown <len.brown@intel.com>, linux-pm@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Sat, 02 Apr 2011 02:22:58 -0400
Len Brown <lenb@kernel.org> wrote:

> From: Len Brown <len.brown@intel.com>
> 
> There is some doubt whether the APM idle feature
> to call into the BIOS from the idle loop is reliable.
> Certainly it was known to fail on some machines,

And it was known to work on lots - a point that despite repeated
reminding you seem keen to ignore.

The fundamental problem I have with this patch set is this

You've provided no architectural overall justification for all this
effort. What is the big picture around your crusade here ? What is the
grand plan ?

> but more importantly, APM machines have not shipped
> for a decade and so finding machines to test the code
> is problematic.

So don't test it - if it's wrong someone will let you know, believe me 8)

And 2.6.40 is far too soon - it takes about a year for stuff to rattle
through to leading edge distro users in bulk

Alan
