From: Dmitry Torokhov <dtor@insightbb.com>
Subject: [RFC/PATCH 0/3] Integrating struct class_device into
	power management framework
Date: Wed, 11 Oct 2006 02:01:38 -0400
Message-ID: <20061011060138.920913139.dtor@insightbb.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: linux-pm@lists.osdl.org
Cc: Andrew Morton <akpm@osdl.org>, Kay Sievers <kay.sievers@vrfy.org>, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Hi,

The following patches integrate class devices into common PM framework.
Classes can define 2 new methods: pause() and restart() that will be
called at suspend and resume time respectively. This will ease hardware
driver's tasks at suspend and resume time by moving common code into
classes.

The advantages of integrating class_device over moving to struct device:

 - no need to reshuffle entire kernel, subsystems can be converted
   one by one without a flag day;
 - struct device will not become a kitchen sink.

--
Dmitry
