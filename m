From: Jia Hongtao <hongtao.jia-3arQi8VN3Tc@public.gmane.org>
Subject: [PATCH 0/3] QorIQ TMU bindings and device tree update
Date: Wed, 4 Jan 2017 16:57:48 +0800
Message-ID: <1483520271-3838-1-git-send-email-hongtao.jia@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: oss-fOR+EgIDQEHk1uMJSBkQmQ@public.gmane.org, rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, edubezval-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, yuantian.tang-3arQi8VN3Tc@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Cc: linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, hongtao.jia-3arQi8VN3Tc@public.gmane.org
List-Id: linux-pm@vger.kernel.org

As Rui Zhang suggested I combine TMU binding patch and two device tree patchset
together. He will take all of them after the device tree patchset got ACK.

@Scott please help to review the device tree patchset.
Thanks.

Jia Hongtao (3):
  dt-bindings: Update QorIQ TMU thermal bindings
  powerpc/mpc85xx: Update TMU device tree node for T1040/T1042
  powerpc/mpc85xx: Update TMU device tree node for T1023/T1024

 Documentation/devicetree/bindings/thermal/qoriq-thermal.txt | 7 +++++++
 arch/powerpc/boot/dts/fsl/t1023si-post.dtsi                 | 4 ++--
 arch/powerpc/boot/dts/fsl/t1040si-post.dtsi                 | 4 ++--
 3 files changed, 11 insertions(+), 4 deletions(-)

-- 
2.1.0.27.g96db324

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
