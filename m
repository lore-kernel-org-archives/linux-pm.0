Return-Path: <linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76EAAC433EF
	for <linux-pm@archiver.kernel.org>; Sun, 22 May 2022 20:18:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234319AbiEVUSe (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Sun, 22 May 2022 16:18:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233422AbiEVUSd (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 22 May 2022 16:18:33 -0400
X-Greylist: delayed 1757 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 22 May 2022 13:18:32 PDT
Received: from out1.nocdirect.com (out1.nocdirect.com [69.73.171.0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD07C36695
        for <linux-pm@vger.kernel.org>; Sun, 22 May 2022 13:18:32 -0700 (PDT)
Received: from binky.nswebhost.com ([69.73.168.248])
        by spamexperts03.nocdirect.com with esmtpsa (TLSv1.2:AES128-GCM-SHA256:128)
        (Exim 4.92)
        (envelope-from <support@iesottawa.ca>)
        id 1nsrZV-0000Ye-Tr
        for linux-pm@vger.kernel.org; Sun, 22 May 2022 15:49:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=iesottawa.ca; s=default; h=Sender:Content-Type:MIME-Version:Message-ID:
        Reply-To:From:Date:Subject:To:Cc:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=tsytaq9P6jbx84sZaeZ2ujyYY054YqWU2QI73VCcE8s=; b=I+EfnWt5bqJC4xa+PwRgY6FKGp
        zPGSPqkAN0AS0UJ4AcCvSfT9kuLs4IXMQGAgKCBkl1NA/clu6NHT4KAFk5Z4tk4qx5DabV/K62egO
        S6CSXuqcdUNUKTdtLVivefvA9TcqnxPGbV0DJF7etDxa2Ij0JI3vaRRNTUHl9CzpIJgfYV2R+l3HE
        XEtWMZpE8bjnTj2VWh7hV+48goTlJNVbx6sAZR7e2Q1kxF5AeEt59UgMmbu7A+EMkm0iXx0VPn5EW
        TC0RJfcPCdnKy4m6nUyGzt5Xi7f9AwDHY55I4jaaLX8tgpTgUzfImqzCqNq8wc9hqoIJ4wTWXSEWC
        4BNHWc8A==;
Received: from ottawa by binky.nswebhost.com with local (Exim 4.93)
        (envelope-from <support@iesottawa.ca>)
        id 1nsrYV-0007Cx-EW
        for linux-pm@vger.kernel.org; Sun, 22 May 2022 15:47:59 -0400
To:     linux-pm@vger.kernel.org
Subject: Re: Looking forward to hearing from you
X-PHP-Script: iesottawa.ca/modules/mod_simplefileuploadv1.3/elements/bcqkhulk.php for 36.37.185.70
Date:   Sun, 22 May 2022 19:47:59 +0000
From:   "Mrs. Mamand Mashamsul" <support@iesottawa.ca>
Reply-To: mrsmamands@gmail.com
Message-ID: <2de91cbf2578d631cdd4e0bdd8d4d626@iesottawa.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender:  <ottawa@binky.nswebhost.com>
X-Originating-IP: 69.73.168.248
X-SpamExperts-Domain: nocdirect.com
X-SpamExperts-Username: binky
Authentication-Results: nocdirect.com; auth=pass (login) smtp.auth=binky@nocdirect.com
X-SpamExperts-Outgoing-Class: unsure
X-SpamExperts-Outgoing-Evidence: Combined (0.83)
X-Recommended-Action: accept
X-Filter-ID: Pt3MvcO5N4iKaDQ5O6lkdGlMVN6RH8bjRMzItlySaT9NxnHXhFI9aLFhf4G9YVDvPUtbdvnXkggZ
 3YnVId/Y5jcf0yeVQAvfjHznO7+bT5w9+NB0706U/e5JSnH+B9KnW4h0KqOTIGbSh7sPxo0b07gN
 zB/4Jkrw1eDLcif59fsIsT83vl+1bmtnUwX2zThxgYVALhXkueKT79r7FRLqfcoJDehyBsdBu50D
 mtW4oaJLav+rNhkBvA/yx3UOkyxilU4PumfG+1zay7DesNa5m5kncdbkChqOd1xRCjRXrOUo6w9/
 xJPGBYLRFSVc+fdHZK0EMmf3P50Ajf/tIX00Fi2UzZMb4kuX6D5eETmGUuUcqbdy+7WYS7ujrPXH
 qhox0HpT3S2SFmqVvJUoDpLg17fDQD9rTYKpWUjzugBu3bR7NBygveb6c8kYDlcMKNLdfoLeZ09b
 xZt+2giPJq6hQNKJ9zpkh4CBVZNevlN99LDk6xV06FcgZkQoEFV+s1chVLvKs3jED+rkxy9HfVI3
 2AJ/g31PqNR+MEBwOQya+LjmlTqiXb5DktChYWJ+7Vxty4Cn30yIJe57hjvyCVNd+NjlDHh8k6TT
 dHl8m1/8O/+GvmcnNbFGJXJDA267gIcXe8nVzIfQ9pH2EV9pPX+JYOKK2nN+Ec8agd1+3wZtTuax
 8jRGiTUr3xlJM6AS3uCbJ+tdNWrmGmSjHHXIaEZaAhi6R+2ZJAIWHs0KPnepAlMlC1QqG5wZG0oX
 2QUKBbmIiwQzKw+6v3CaIMG6s7LqJIQj1LuoK31lBRJSSr7O4nJm4eDGPWQjiHziZaTK5a5hn1s1
 h9hckh1ZbTQPe2LI2pRncTcSaSwH1WBJUBsJy7hDPDo3pDJlUlQ25PasjIMI/mKKM1+EgghWm5D0
 3bCLK+uO5TcDeKjrEmYPn2IVWRvTk6nHRRspqNsaP48+Pyzv2RAMUzcxPFk6QeElJUkx8BJ8JwTn
 a1RcqY1+KjpDJopf41QeuQVkfXoTGRWEU/OLQ+Z6IxeQ3uxPHIN2qm5xKroy2+XMVhIoa/OtSSGm
 Yp9mtlRTKBfv33uOwsmJdRic
X-Report-Abuse-To: spam@spamexperts01.nocdirect.com
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Greatings Dear

I am Mrs. Mamand Mashamsul, from Kabul, Capital of Afghanistan. With due respect, I want to know if foreigners can buy and own properties in your beautiful country, I desire to relocate my investment capital abroad where it will generate more returns. 
 
I will appreciate your response. Please let me know your ideas and knowledge regarding my research. In Any viable investment idea you suggest to me will be also be considered. 
 
Looking forward to hearing from you.

Best regards,
Mrs. Mamand Mashamsul

