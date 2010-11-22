From: Len Brown <lenb@kernel.org>
Subject: Re: [git pull 2.6.36.stable] intel_idle patches for
 2.6.36.stable
Date: Mon, 22 Nov 2010 13:36:31 -0500 (EST)
Message-ID: <alpine.LFD.2.00.1011221318230.19247__11969.4750676446$1290451072$gmane$org@x980>
References: <alpine.LFD.2.00.1011151227190.2939@x980>
	<alpine.LFD.2.00.1011170322270.24426@x980>
	<alpine.LFD.2.00.1011170331150.24426@x980>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-reply-to: <alpine.LFD.2.00.1011170331150.24426@x980>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: stable@kernel.org
Cc: linux-pm@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Hi Greg,

I retract my intel_idle pull requests for .stable

The idle-release branches in...
git://git.kernel.org/pub/scm/linux/kernel/git/lenb/
	linux-idle-2.6.32.git
	linux-idle-2.6.35.git
	linux-idle-2.6.36.git

are for distros and others that want to run the latest intel_idle
driver on the specified release.  The backports in these trees
contain every upstream patch that touch the driver, including new
platform support and any dependent cosmetic patches.

So they are optimized for the maintenance task of comparing
the backport versus the upstream driver to verify the release
includes everything that is upstream.
However, as it does not exclude cosmetic or trivial patches,
the backports do not qualify for inclusion in .stable.

Sorry to bother you.

thanks,
Len Brown, Intel Open Source Technology Center
