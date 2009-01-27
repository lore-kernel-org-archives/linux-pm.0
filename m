From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH 0/1] PM/Hibernate: fix "swap breaks after
	hibernation failures"
Date: Tue, 27 Jan 2009 23:17:42 +0100
Message-ID: <200901272317.43512.rjw__7485.08823239735$1233095011$gmane$org@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
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
To: Len Brown <lenb@kernel.org>
Cc: pm list <linux-pm@lists.linux-foundation.org>, Alan Jenkins <alan-jenkins@tuffmail.co.uk>, LKML <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@suse.cz>
List-Id: linux-pm@vger.kernel.org

Hi Len,

The following patch fixes a long-standing bug in the hibernate code related to
swap, which causes the swap partition used for saving hibernation images to
become unusable after two consecutive failing attempts to hibernate.

Please add to the suspend branch as 2.6.29 material.

Thanks,
Rafael
