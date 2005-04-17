From: Adam Belay <abelay@novell.com>
Subject: [RFC] Power Management Policies
Date: Sun, 17 Apr 2005 17:15:32 -0400
Message-ID: <1113772533.3451.131.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============80421487874792907=="
Return-path: <linux-pm-bounces@lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

--===============80421487874792907==
Content-Type: text/plain
Content-Transfer-Encoding: 7bit


Hi All,

I was wondering if you had any thoughts on how power management policies
should be configured by userspace.  It seems like the central question
here is how much of the decision should occur in kernel-space.

For example, on one extreme we could have each policy manager define a
list of policies and allow the user to select one.  So, in my model, the
user might tell a "power device" to use the policy "max performance" or
"emergency power-save".  One could argue that these decisions are too
complex and device specific for userspace to be reliable.  It would give
the driver author, who likely has extensive knowledge of the pm
capabilities of the device, a chance to include power management
policies with the driver.

On the other extreme, we could allow userspace to configure every
timeout value, and other policy attributes.  The user would be in
complete control, but may not be aware of how long the transitions will
take, how much power will be consumed by the transition, or what the
manufacturer intended.  If the user wanted a disk drive to turn off
after 1 ms of inactivity, there would be nothing stopping that.  Of
course, one could argue that the kernel shouldn't be making policy
decisions, and we should throw these toward the layer above us.

One other option is to allow userspace to actually tell the devices
which state to switch to.  I'd argue against this, because I think that
userspace cannot disable a device that it needs to function.

I personally have some concerns over too much userspace interaction.  I
think these decisions are too device specific, and if we don't take
responsibility for them, then the layers above the kernel may not be
able to properly handle it.  Also I think that some decisions may need
to be made very quickly.  In the end, we will probably make a compromise
between these extremes.  I would appreciate any opinions or suggestions.

Thanks,
Adam



--===============80421487874792907==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============80421487874792907==--
