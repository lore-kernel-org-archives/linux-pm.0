From: ??? <ikhwan.lee@samsung.com>
Subject: sysfs power/state file & dpm_runtime_suspend()
Date: Thu, 27 Jul 2006 20:34:08 +0900
Message-ID: <019501c6b170$93eb6950$4686190c@dsn.sec.samsung.com>
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
List-Id: linux-pm@vger.kernel.org

Hi,

It seems that we have a consensus on the obsoleteness of the sysfs
power/state
file and dev->power.power_state.event. Could anybody explain why? I have
recently
joined this mailing list and I would like to follow up with the technical
background of
this agreement.

If the sysfs mechanism is deprecated, the dpm_runtime_suspend() seems to be
the only method for runtime power management. But I think it's difficult for
a user-
space power manager to use this function because the caller needs to have
the pointer
to the device which it wants to control.

Lastly, shouldn't the dpm_runtime_suspend() move the device from dpm_active
list
to dpm_off list upon success? This would prevent suspending an
already-suspended
device again in the device_suspend() function.

Ikhwan
