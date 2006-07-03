From: <rasmit.ranjan@wipro.com>
Subject: content of /sys/power/state
Date: Mon, 3 Jul 2006 18:00:51 +0530
Message-ID: <380D9721A8E2114485644D71E87C6AB202212E23@PNE-HJN-MBX01.wipro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
Content-class: urn:content-classes:message
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
List-Id: linux-pm@vger.kernel.org

Hi,
    I have a little doubt regarding which mode of global suspend my
system supports.
When i do cat /sys/power/state, it gives

Standby mem disk

Does this mean that my system supports all standby, suspend to RAM and
suspend to disk as well? But only suspend to disk works and other two
does not. So what might be the cause?
Please suggest.

Thanks,
Rasmit.
