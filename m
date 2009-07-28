From: Ben Dooks <ben-linux@fluff.org>
Subject: Converting to dev_pm_ops (remove annoying warnings)
Date: Tue, 28 Jul 2009 11:44:34 +0100
Message-ID: <20090728104434.GA1728__48487.3705580414$1248793270$gmane$org@fluff.org.uk>
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
To: linux-kernel@vger.kernel.org
Cc: linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

I have a couple of questions about changing drivers to use the
dev_pm_ops method within drivers using the device driver model.

1) Should the suspend/resume code still be wrapped in #ifdef CONFIG_PM
   and supply a NULL 'struct dev_pm_ops' wen CONFIG_PM=n

2) Is it allowable to submit changes to move drivers to dev_pm_ops
   during the -rc phase, or do we have to wait for the merge window
   before sending these? The number of warnings on a system that
   relies heavily on platform devices is annoying (S3C24XX ARM).

-- 
Ben (ben@fluff.org, http://www.fluff.org/)

  'a smiley only costs 4 bytes'
