From: Zhang Rui <rui.zhang@intel.com>
Subject: [RFC] why do we need run disk sync before entering S3
Date: Wed, 13 May 2009 09:20:51 +0800
Message-ID: <1242177651.16529.26.camel__31332.7290503823$1242177766$gmane$org@rzhang-dt>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: linux-pm <linux-pm@lists.linux-foundation.org>, linux-acpi <linux-acpi@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi, all,

I did some S3 tests on an eeepc901, the total suspend time(from issue
the suspend command to power down) is about 2.5s~3s.
something interesting is that kernel runs disk sync before entering S3
state, and this takes about 0.7~1.2s.
my question is that, why do we need this for s2ram?
can we remove this and run sys_sync for S4 only?

thanks,
rui
