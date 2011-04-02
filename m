From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 04/18] x86 idle: EXPORT_SYMBOL(default_idle,
 pm_idle) only when APM demands it
Date: Sat, 2 Apr 2011 12:28:57 +0100
Message-ID: <20110402122857.5fb7d2b7__35341.8598337614$1301743756$gmane$org@lxorguk.ukuu.org.uk>
References: <alpine.LFD.2.02.1104010020280.2797@x980>
	<1301725380-10579-1-git-send-email-lenb@kernel.org>
	<dba24a423948935d0a0c1eb32414a476f3f90e02.1301724243.git.len.brown@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <dba24a423948935d0a0c1eb32414a476f3f90e02.1301724243.git.len.brown@intel.com>
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
Cc: Len Brown <len.brown@intel.com>, linux-pm@lists.linux-foundation.org, x86@kernel.org, linux-kernel@vger.kernel.org, Jiri Kosina <jkosina@suse.cz>
List-Id: linux-pm@vger.kernel.org

On Sat, 02 Apr 2011 02:22:46 -0400
Len Brown <lenb@kernel.org> wrote:

> From: Len Brown <len.brown@intel.com>
> 
> In the long run, we don't want default_idle() or (pm_idle)() to
> be exported outside of process.c.  Start by not exporting them
> to modules, unless the APM build demands it.

Pointless added complexity. Why are you so determined to minimise this -
it makes no odds to anyone.
