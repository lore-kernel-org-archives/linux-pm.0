From: Ferenc Wagner <wferi@niif.hu>
Subject: Re: intermittent suspend problem again
Date: Wed, 28 Oct 2009 12:43:29 +0100
Message-ID: <87fx93pwv2.fsf@tac.ki.iif.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: Ferenc Wagner's message of "Thu, 30 Jul 2009 13:29:46 +0200"
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

Hi,

Something similar to http://bugzilla.kernel.org/show_bug.cgi?id=13894
raised its ugly head again, please see my last comments on that bug.
2.6.32-rc5 feels particularly bad, with frequent failures to switch
off the machine after "S|" or freezes after "Snapshotting system".
The former does not cause much trouble in itself, as the machine can
be switched off and resumed all right, but the latter is nasty.
Suspend to RAM works all the time.  The issue is not reproducible,
unfortunately, and the kernel change happened almost together with a
BIOS upgrade.  Yesterday I switched back to 2.6.31 to see whether it
still works stably with the new BIOS.  I'll report back my findings in
a couple of days.
-- 
Regards,
Feri.
