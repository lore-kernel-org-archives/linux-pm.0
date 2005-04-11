From: Li Shaohua <shaohua.li@intel.com>
Subject: Re: [RFC] Mapping Device Power States
Date: Mon, 11 Apr 2005 17:50:09 +0800
Message-ID: <1113213009.8161.13.camel@sli10-desk.sh.intel.com>
References: <1112909150.21887.18.camel@linux.site>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============86979123727542262=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <1112909150.21887.18.camel@linux.site>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Adam Belay <abelay@novell.com>
Cc: Linux-pm mailing list <linux-pm@lists.osdl.org>
List-Id: linux-pm@vger.kernel.org

--===============86979123727542262==
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Fri, 2005-04-08 at 05:25, Adam Belay wrote:
> 
> POWER_ON: the device is fully functional
> POWER_LIGHT: device context and configuration are maintained, but
> device
> isn't functional.
> POWER_MODERATE: device configuration is maintained, but the context is
> not.  The device isn't functional
> POWER_DEEP: no device configuration or context is maintained, but
> device
> is not fully off.  The device is not functional.
> POWER_OFF: no power is applied to the device.  The device is not
> functional.
I think there are two POWER_OFF. One is the device is not functional but
its related device such as PIC is enabled. And the other is its related
device is disabled. In STR, the state of a device is it's powroff and
its related devices such as the pic/ioapic pin and irq router is are
disabled/masked.

Thanks,
Shaohua


--===============86979123727542262==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============86979123727542262==--
