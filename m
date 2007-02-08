From: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH 02/12] powermac: support G5 CPU hotplug
Date: Fri, 9 Feb 2007 08:59:53 +1100
Message-ID: <17867.40281.175422.116673@cargo.ozlabs.ibm.com>
References: <20070207124536.963531000@sipsolutions.net>
	<20070207124610.392302000@sipsolutions.net>
	<1170940494.4385.51.camel@johannes.berg>
	<1170941321.4385.61.camel@johannes.berg>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <1170941321.4385.61.camel@johannes.berg>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linuxppc-dev@ozlabs.org, linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

Johannes Berg writes:

> +#ifdef CONFIG_CPU_HOTPLUG
> +	/* if we have fake CPU hotplug just to support suspend to disk
> +	 * and can't really turn off a CPU, it may be taking timer interrupts
> +	 * even when it is dead. Avoid doing anything in that case so global
> +	 * state is not modified for and by a CPU that doesn't really exist. */
> +	if (__get_cpu_var(cpu_state) =3D=3D CPU_DEAD)
> +		return;
> +#endif

Are you sure this is necessary?  IIRC, the if (!cpu_is_offline(cpu)) a
little bit further down is there to cope with this exact situation.
And cpu hotplug already works on G4 SMP powermacs, where we can't
physically remove the cpu either - we just put it into sleep mode with
interrupts disabled, which is what we would be doing on a G5 powermac
also.

Paul.
