From: "HU TAO-TGHK48" <taohu@motorola.com>
Subject: PM interface to suspend/resume individual/specific device
Date: Sun, 5 Jul 2009 19:33:13 +0800
Message-ID: <F12CE1A68F023D498A2691C7B539311503655A9A@ZMY16EXM66.ds.mot.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-class: urn:content-classes:message
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

Below command would suspend all of devices and system
# echo mem > /sys/power/state  

How to just suspend/resume one specific devices? E.g.
/sys/devices/platform/serial8250

It would be useful to test the stability of PM interface of individual
driver.
If drivers called earlier refuse to suspend then not able to reach the
suspend/resume function of the specific driver.

And it would be useful for automatic testing since a script can
suspend/resume the specific device for many times without manual
operation.

Is it possible to add "state" for each device?
E.g. 
# echo mem > /sys/devices/platform/serial8250/power/state






 
