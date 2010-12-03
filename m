From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Subject: regulator: multiple consumers requirements
Date: Fri,  3 Dec 2010 11:31:06 +0100
Message-ID: <1291372267-23221-1-git-send-email-thomas.petazzoni@free-electrons.com>
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
To: linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

Hello,

The following patch slightly extends the semantic of
regulator_set_voltage() so that it takes into account the voltage
requirements of all consumers connected to that regulator. This change
would allow the OMAP ARM architecture to use the regulator framework
more aggressively: we have multiple devices connected to a single
regulator, and the voltage needs to be set to the minimum voltage
acceptable by all consumers.

Thanks,

Thomas
