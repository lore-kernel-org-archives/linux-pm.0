From: Vasiliy Kulikov <segoon@openwall.com>
Subject: Re: [PATCH] power: disable hibernation if module loading
 is disabled
Date: Sat, 5 Mar 2011 13:34:44 +0300
Message-ID: <20110305103444.GA26773__6577.11787284843$1299321367$gmane$org@albatros>
References: <1299255084-4390-1-git-send-email-segoon@openwall.com>
	<201103042221.02852.rjw@sisk.pl> <20110304214630.GA29883@albatros>
	<201103042330.25079.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <201103042330.25079.rjw@sisk.pl>
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
Cc: Len Brown <len.brown@intel.com>, security@kernel.org, linux-kernel@vger.kernel.org, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Fri, Mar 04, 2011 at 23:30 +0100, Rafael J. Wysocki wrote:
> modules_disabled surely is not the right interface to disable hibernation
> and I don't really think there's a bug because it doesn't work as you'd like
> it to.  In fact, there would be a bug if it did work that way.

What do you mean here?  Do you agree that you may read kernel image,
slightly change it (including e.g. possible checksums, I didn't bother
to check how much one should change), and write it back?

-- 
Vasiliy Kulikov
http://www.openwall.com - bringing security into open computing environments
