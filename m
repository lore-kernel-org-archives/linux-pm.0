From: 640E9920 <640e9920@gmail.com>
Subject: [PATCH] PM_QOS updates for 2.6.34-rc1
Date: Sat, 13 Mar 2010 16:34:25 -0800
Message-ID: <20100314003425.GA17812__19843.8612897464$1268526953$gmane$org@mgross-acer>
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
To: linux-pm@lists.linux-foundation.org, linux-kernel@vger.kernel.org, dwalker@codeaurora.org, tiwai@suse.de, bruce.w.allan@intel.com, aili@codeaurora.org, khilman@deeprootsy
List-Id: linux-pm@vger.kernel.org

The following patch series implements to following:
1) pm_qos now uses a handle based implementation.  No more string
compares while walking lists.
2) renames the exports to using more accurate names.
3) updates kernel clients of pm_qos per this change
4) added ascii interface to pmqos recognizing strings formatted in 10
charactor format "0x12345678"
5) added new pm_qos class, "system_bus_throughput"

I would like to see this series make it into 2.6.34 if its not too late. 

I was able to test it on my laptop and comments welcome.

Thank you!

--mgross
