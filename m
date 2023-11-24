Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B43331BEE;
	Fri, 24 Nov 2023 10:23:15 -0800 (PST)
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-1efba24b038so559917fac.1;
        Fri, 24 Nov 2023 10:23:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700850195; x=1701454995;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yJprSLoTWn621TBDytAlqAwQCsAGg9NIQj2Zk6cryOQ=;
        b=cVVZ25mMvDf3ZFngYV8JW7anvkuTI2LOO7ljLWo8uyPxBEERvS57uhDABUNjSb7zP6
         SuqG/r+w7dC82CsqyDjOEaDKBHGr0oWGKFkIlj3TttnLiRhHmuVN1dcAvcnGVMjPAUgB
         0YnoeDjDeHmz4WlZO1ZbgZHZjt7FLlKFJXp9tHzVSVHk7bd3aZAr/t2uJQPzOqhnIJH+
         +EpHhyMjpatfeDbGK4vm3Z8X9oIh6eRAKT/7S1FNA5k7oblFLLlb09anRE3EYxvh+/8l
         m63vFhxhB38tTt1EMH1O+LRLc6cB1w1d3PFfSQEGUU8WTYhvzYreaL1jvk2CsrIQmBGE
         W7dg==
X-Gm-Message-State: AOJu0YzmMyWUE/bQwvFtijYdpHbCt5o8sA0hPspnzXVCByEcshM7B08I
	EufbRwJ0T8FvKKs/Rz4M0xXIxO+qvAFmyhHyFngNi5pvUaU=
X-Google-Smtp-Source: AGHT+IFofsLTyC/8g5Ejh30FSkwrUc/rVvJEFhhhJuLEsd7CWE645e9yhluqKl66tjyXQU5W/q7Ah/Mkno/3BBHBktM=
X-Received: by 2002:a05:6870:b510:b0:1f5:ecc7:2756 with SMTP id
 v16-20020a056870b51000b001f5ecc72756mr4378625oap.4.1700850194815; Fri, 24 Nov
 2023 10:23:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 24 Nov 2023 19:23:03 +0100
Message-ID: <CAJZ5v0gO3nY5nSnsFUha5a9WiOAj6kZLek0sVSB49NiweFw4_w@mail.gmail.com>
Subject: [GIT PULL] Power management fix for v6.7-rc1
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux PM <linux-pm@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 pm-6.7-rc3

with top-most commit b85e2dab33ce467e8dcf1cb6c0c587132ff17f56

 PM: tools: Fix sleepgraph syntax error

on top of commit 98b1cc82c4affc16f5598d4fa14b1858671b2263

 Linux 6.7-rc2

to receive a power management fix for 6.7-rc3.

This fixes a syntax error in the sleepgraph utility which causes it to
exit early on every invocation (David Woodhouse).

Thanks!


---------------

David Woodhouse (1):
      PM: tools: Fix sleepgraph syntax error

---------------

 tools/power/pm-graph/sleepgraph.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
