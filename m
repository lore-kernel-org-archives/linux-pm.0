From: Tabor Kvasnicka <kamakwazee@gmail.com>
Subject: Linux Suspend Bug
Date: Sat, 08 Nov 2014 18:19:18 -0600
Message-ID: <545EB306.6040207@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oi0-f41.google.com ([209.85.218.41]:41838 "EHLO
	mail-oi0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751231AbaKIATV (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sat, 8 Nov 2014 19:19:21 -0500
Received: by mail-oi0-f41.google.com with SMTP id e131so3970115oig.14
        for <linux-pm@vger.kernel.org>; Sat, 08 Nov 2014 16:19:20 -0800 (PST)
Received: from [192.168.0.18] ([74.197.224.168])
        by mx.google.com with ESMTPSA id t16sm5339685oif.0.2014.11.08.16.19.19
        for <linux-pm@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 08 Nov 2014 16:19:20 -0800 (PST)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org

The mainline upstream version of the kernel has a bug that won't allow
for my computer to fully suspend.

Link to bug: https://bugzilla.kernel.org/show_bug.cgi?id=87961

I have provided information based on the bug reporting instructions, but
I will provide any other information you need to help fix this problem.
