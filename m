From: "Leisner, Martin" <Martin.Leisner@xerox.com>
Subject: power draw depending on PHY speed
Date: Fri, 28 Aug 2009 08:26:13 -0700
Message-ID: <76FA3B279DD9DA48896E2B40494495720368E449@USA7061MS02.na.xerox.net>
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
Cc: martyleisner@yahoo.com
List-Id: linux-pm@vger.kernel.org

While doing some current probe measurements (i.e. to measure the effects
of NAP and frequency scaling with a freescale processor) I noticed some
very
significant differents if we ran on 100Mbit of 1000Mbit ethernet.

The hardware guys like at their data sheets and agreed.

Does anyone "drop ethernet speed" to save power?
(when a system is idle, is isn't necessary to run 1G ethernet).


When a system has WOL capability, what speed does it run at when the
system
is sleeping?

marty
