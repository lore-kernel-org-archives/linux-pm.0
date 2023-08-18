Return-Path: <linux-pm-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A2C0C7113D
	for <linux-pm@archiver.kernel.org>; Fri, 18 Aug 2023 09:02:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358864AbjHRJBv (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Fri, 18 Aug 2023 05:01:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358900AbjHRJBb (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 18 Aug 2023 05:01:31 -0400
X-Greylist: delayed 1474 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 18 Aug 2023 02:00:58 PDT
Received: from mail.leachkin.pl (mail.leachkin.pl [217.61.97.203])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D0AC3C32
        for <linux-pm@vger.kernel.org>; Fri, 18 Aug 2023 02:00:58 -0700 (PDT)
Received: by mail.leachkin.pl (Postfix, from userid 1001)
        id 9BB368441B; Fri, 18 Aug 2023 09:16:13 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=leachkin.pl; s=mail;
        t=1692346587; bh=elHzctRz/z3PfTIhGYJKd0TeBTmca98Y+JNgX4gfsPI=;
        h=Date:From:To:Subject:From;
        b=Q7ngzbbd2KmEK4xdxjv+8rKXF56QQLMH/ok8mME13OXsqrOsrNJ2U56oSgWjpYqvw
         mikmP0p0j4oUXE7olPNeRe+5y7/NI/H8MTxy+9QZMzui9bWgi7GKSnxwvELTXq1PSe
         u+ntItb7KPsAvooS8hI7rJOc+n06wlef7llwHdI237TYmXLNb/G6dbr/7fU0YJeeFA
         /nhOnVZ+x13LzhZeOsq2H6TlMDIh5TJjv1qH0qoBhuvR+LZ5Pff57bMfXig9EqQruY
         w2j3DQLSRFkJxOrCgCXVILhULyxF4gl2HtCESVLEwU+IQp1yO5OqYIX6V+EwURVj1t
         t7U1xxT+hwOlQ==
Received: by mail.leachkin.pl for <linux-pm@vger.kernel.org>; Fri, 18 Aug 2023 08:15:51 GMT
Message-ID: <20230818074501-0.1.4u.cu14.0.70xk7j95gf@leachkin.pl>
Date:   Fri, 18 Aug 2023 08:15:51 GMT
From:   "Jakub Lemczak" <jakub.lemczak@leachkin.pl>
To:     <linux-pm@vger.kernel.org>
Subject: =?UTF-8?Q?Pytanie_o_samoch=C3=B3d?=
X-Mailer: mail.leachkin.pl
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Dzie=C5=84 dobry,

Czy interesuje Pa=C5=84stwa rozwi=C4=85zanie umo=C5=BCliwiaj=C4=85ce moni=
torowanie samochod=C3=B3w firmowych oraz optymalizacj=C4=99 koszt=C3=B3w =
ich utrzymania?=20


Pozdrawiam,
Jakub Lemczak
