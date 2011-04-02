From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 03/18] x86 idle APM: deprecate
	CONFIG_APM_CPU_IDLE
Date: Sat, 2 Apr 2011 20:44:12 +0100
Message-ID: <20110402204412.729b85ba__14830.0871173435$1301773486$gmane$org@lxorguk.ukuu.org.uk>
References: <alpine.LFD.2.02.1104010020280.2797@x980>
	<1301725380-10579-1-git-send-email-lenb@kernel.org>
	<392e1ffeeaefd448f69d45041fe4406fbd197852.1301724243.git.len.brown@intel.com>
	<20110402122810.1371afa8@lxorguk.ukuu.org.uk>
	<alpine.LFD.2.02.1104021427040.18682@x980>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <alpine.LFD.2.02.1104021427040.18682@x980>
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
Cc: Len Brown <len.brown@intel.com>, Jiri Kosina <jkosina@suse.cz>, x86@kernel.org, linux-kernel@vger.kernel.org, linux-pm@lists.linux-foundation.org, stable@kernel.org
List-Id: linux-pm@vger.kernel.org

On Sat, 02 Apr 2011 14:28:31 -0400 (EDT)
Len Brown <lenb@kernel.org> wrote:

> > Give it a year, it doesn't cause any complexities I can see.
> 
> I'd rather not create a new an APM cpuilde driver

In which case don't remove the existing one - as far as bugzilla shows it
seems to be working fine.
